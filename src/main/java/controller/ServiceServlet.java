package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Action_Service;
import service.ServiceService;

import java.io.IOException;
import java.util.List;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.net.URLEncoder; // Cần thiết cho việc mã hóa thông báo
import java.nio.charset.StandardCharsets; // Sử dụng cho URLEncoder

@WebServlet("/c")
public class ServiceServlet extends HttpServlet {
    private final ServiceService serviceService = ServiceService.getInstance();

    // Phương thức helper để mã hóa thông báo và chuyển hướng
    private void sendRedirectWithMessage(HttpServletResponse response, String url, String message, boolean isError) throws IOException {
        String separator = url.contains("?") ? "&" : "?";
        String type = isError ? "error" : "message";
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
        response.sendRedirect(url + separator + type + "=" + encodedMessage);
    }

    // --------------------------------- doGet ---------------------------------

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        String contextPath = request.getContextPath();
        String listUrl = contextPath + "/services";

        switch (action) {
            case "addForm":
                request.getRequestDispatcher("/WEB-INF/views/add-service.jsp").forward(request, response);
                break;
            case "editForm":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Action_Service editService = serviceService.getServiceById(id);
                    if (editService != null) {
                        request.setAttribute("service", editService);
                        request.getRequestDispatcher("/WEB-INF/views/edit-service.jsp").forward(request, response);
                    } else {
                        sendRedirectWithMessage(response, listUrl, "Không tìm thấy dịch vụ để sửa.", true);
                    }
                } catch (NumberFormatException e) {
                    sendRedirectWithMessage(response, listUrl, "ID dịch vụ không hợp lệ.", true);
                } catch (Exception e) {
                    e.printStackTrace();
                    sendRedirectWithMessage(response, listUrl, "Lỗi khi truy cập form sửa.", true);
                }
                break;
            case "detail":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Action_Service detailService = serviceService.getServiceById(id);

                    if (detailService != null) {
                        request.setAttribute("service", detailService);
                        LocalDateTime localDateTime = detailService.getCreated_at();

                        if (localDateTime != null) {
                            Date createdDate = Date.from(
                                    localDateTime.atZone(ZoneId.systemDefault()).toInstant()
                            );
                            request.setAttribute("createdDateJSTL", createdDate);
                        }
                        request.getRequestDispatcher("/WEB-INF/views/service-detail.jsp").forward(request, response);
                    } else {
                        sendRedirectWithMessage(response, listUrl, "Không tìm thấy dịch vụ chi tiết.", true);
                    }
                } catch (NumberFormatException e) {
                    sendRedirectWithMessage(response, listUrl, "ID dịch vụ không hợp lệ.", true);
                } catch (Exception e) {
                    e.printStackTrace();
                    sendRedirectWithMessage(response, listUrl, "Lỗi khi xem chi tiết dịch vụ.", true);
                }
                break;
            case "delete":
                int deleteId = 0;
                try {
                    deleteId = Integer.parseInt(request.getParameter("id"));
                    serviceService.deleteService(deleteId);
                    String message = "Dịch vụ ID " + deleteId + " đã được xóa thành công.";
                    // CHUYỂN HƯỚNG VỀ DANH SÁCH với thông báo thành công
                    sendRedirectWithMessage(response, listUrl, message, false);
                } catch (NumberFormatException e) {
                    sendRedirectWithMessage(response, listUrl, "ID không hợp lệ.", true);
                } catch (Exception e) {
                    e.printStackTrace();
                    String message = "Không thể xóa dịch vụ ID " + deleteId + ". Lỗi hệ thống.";
                    sendRedirectWithMessage(response, listUrl, message, true);
                }
                break;
            default:
                // Logic hiển thị danh sách và tìm kiếm
                String searchType = request.getParameter("searchType");
                String keyword = request.getParameter("keyword");
                List<Action_Service> services;
                // ... (Logic tìm kiếm giữ nguyên) ...
                if (searchType != null && keyword != null && !keyword.isBlank()) {
                    // Logic tìm kiếm
                    switch (searchType) {
                        case "name":
                            Action_Service s = serviceService.getServiceByName(keyword);
                            services = (s != null) ? List.of(s) : List.of();
                            break;
                        case "category":
                            services = serviceService.getServicesByCategory(keyword);
                            break;
                        case "technology":
                            services = serviceService.getServicesByTechnology(keyword);
                            break;
                        case "price":
                            try {
                                double price = Double.parseDouble(keyword);
                                services = serviceService.getServicesByPrice(price);
                            } catch (NumberFormatException e) {
                                request.setAttribute("error", "Giá tìm kiếm không hợp lệ.");
                                services = List.of();
                            }
                            break;
                        default:
                            services = serviceService.getAllServices();
                    }
                } else {
                    services = serviceService.getAllServices();
                }
                request.setAttribute("services", services);
                request.getRequestDispatcher("/WEB-INF/views/service-list.jsp").forward(request, response);
                break;
        }
    }

    // --------------------------------- doPost ---------------------------------

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        String redirectUrl = request.getContextPath() + "/services"; // Mặc định về danh sách
        String message = "";
        int serviceId = 0;

        try {
            Action_Service service = new Action_Service();

            // Đọc dữ liệu từ request
            String serviceName = request.getParameter("service_name");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String targetCustomer = request.getParameter("target_customer");
            String process = request.getParameter("process");
            String technology = request.getParameter("technology");
            String duration = request.getParameter("duration");
            String warrantyPolicy = request.getParameter("warranty_policy");
            Double price = Double.parseDouble(request.getParameter("price"));
            boolean isActive = request.getParameter("is_active") != null;

            if ("add".equals(action)) {
                // Thiết lập các thuộc tính cho service
                service.setService_name(serviceName);
                service.setCategory(category);
                service.setDescription(description);
                service.setTarget_customer(targetCustomer);
                service.setProcess(process);
                service.setTechnology(technology);
                service.setDuration(duration);
                service.setWarranty_policy(warrantyPolicy);
                service.setPrice(price);
                service.setIs_active(isActive);

                serviceService.addService(service);

                message = "Thêm dịch vụ thành công.";
                // redirectUrl vẫn là mặc định: /services (chuyển về danh sách)

            } else if ("update".equals(action)) {
                serviceId = Integer.parseInt(request.getParameter("service_id"));
                service.setService_id(serviceId);
                // Thiết lập các thuộc tính còn lại
                service.setService_name(serviceName);
                service.setCategory(category);
                service.setDescription(description);
                service.setTarget_customer(targetCustomer);
                service.setProcess(process);
                service.setTechnology(technology);
                service.setDuration(duration);
                service.setWarranty_policy(warrantyPolicy);
                service.setPrice(price);
                service.setIs_active(isActive);

                serviceService.updateService(service);

                message = "Cập nhật dịch vụ thành công.";
                // CHUYỂN HƯỚNG VỀ TRANG CHI TIẾT sau khi cập nhật thành công
                redirectUrl = request.getContextPath() + "/services?action=detail&id=" + serviceId;
            }

            // THỰC HIỆN CHUYỂN HƯỚNG CUỐI CÙNG (Sử dụng hàm helper để đảm bảo dấu ? và & đúng)
            sendRedirectWithMessage(response, redirectUrl, message, false);

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi giá không phải là số
            request.setAttribute("error", "Lỗi định dạng: Vui lòng nhập giá là số hợp lệ.");

            // Forward lại form, giữ lại dữ liệu
            String view = "add".equals(action) ? "/WEB-INF/views/add-service.jsp" : "/WEB-INF/views/edit-service.jsp";

            if ("update".equals(action)) {
                try {
                    int idToRefill = Integer.parseInt(request.getParameter("service_id"));
                    Action_Service failedService = serviceService.getServiceById(idToRefill);
                    if(failedService != null) {
                        request.setAttribute("service", failedService);
                    }
                } catch (Exception ignore) { /* Bỏ qua lỗi */ }
            }

            request.getRequestDispatcher(view).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể thực hiện hành động " + action + ". Vui lòng thử lại.");
            String view = "add".equals(action) ? "/WEB-INF/views/add-service.jsp" : "/WEB-INF/views/edit-service.jsp";
            request.getRequestDispatcher(view).forward(request, response);
        }
    }
}