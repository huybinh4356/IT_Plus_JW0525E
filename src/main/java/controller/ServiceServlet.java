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

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private final ServiceService serviceService = ServiceService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "list";
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
                        response.sendRedirect(request.getContextPath() + "/services?error=not_found");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/services?error=invalid_id");
                }
                break;
            case "detail":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Action_Service detailService = serviceService.getServiceById(id);

                    if (detailService != null) {
                        // 1. Gán đối tượng Service gốc vào Request
                        request.setAttribute("service", detailService);

                        // 2. LẤY LocalDateTime TỪ MODEL
                        LocalDateTime localDateTime = detailService.getCreated_at();

                        // 3. CHUYỂN ĐỔI sang java.util.Date cho JSTL
                        if (localDateTime != null) {
                            Date createdDate = Date.from(
                                    localDateTime.atZone(ZoneId.systemDefault()).toInstant()
                            );
                            // 4. Gán đối tượng Date đã chuyển đổi vào một thuộc tính mới
                            request.setAttribute("createdDateJSTL", createdDate);
                        }

                        request.getRequestDispatcher("/WEB-INF/views/service-detail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/services?error=not_found");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/services?error=invalid_id");
                }
                break;
            case "delete":
                int deleteId = 0;
                try {
                    deleteId = Integer.parseInt(request.getParameter("id"));
                    serviceService.deleteService(deleteId);
                    response.sendRedirect(request.getContextPath() + "/services?message=Dịch vụ ID " + deleteId + " đã được xóa thành công.");
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/services?error=ID không hợp lệ.");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/services?error=Không thể xóa dịch vụ ID " + deleteId + ".");
                }
                break;
            default:
                String searchType = request.getParameter("searchType");
                String keyword = request.getParameter("keyword");
                List<Action_Service> services;
                if (searchType != null && keyword != null && !keyword.isBlank()) {
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        String redirectUrl = request.getContextPath() + "/services";

        try {
            Action_Service service = new Action_Service();
            if ("add".equals(action)) {
                service.setService_name(request.getParameter("service_name"));
                service.setCategory(request.getParameter("category"));
                service.setDescription(request.getParameter("description"));
                service.setTarget_customer(request.getParameter("target_customer"));
                service.setProcess(request.getParameter("process"));
                service.setTechnology(request.getParameter("technology"));
                service.setDuration(request.getParameter("duration"));
                service.setWarranty_policy(request.getParameter("warranty_policy"));
                service.setPrice(Double.parseDouble(request.getParameter("price")));
                service.setIs_active(request.getParameter("is_active") != null);
                serviceService.addService(service);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("service_id"));
                service.setService_id(id);
                service.setService_name(request.getParameter("service_name"));
                service.setCategory(request.getParameter("category"));
                service.setDescription(request.getParameter("description"));
                service.setTarget_customer(request.getParameter("target_customer"));
                service.setProcess(request.getParameter("process"));
                service.setTechnology(request.getParameter("technology"));
                service.setDuration(request.getParameter("duration"));
                service.setWarranty_policy(request.getParameter("warranty_policy"));
                service.setPrice(Double.parseDouble(request.getParameter("price")));
                service.setIs_active(request.getParameter("is_active") != null);
                serviceService.updateService(service);
                redirectUrl = request.getContextPath() + "/services?action=detail&id=" + service.getService_id();
            }
            response.sendRedirect(redirectUrl + "&message=" + ("add".equals(action) ? "Thêm dịch vụ thành công." : "Cập nhật dịch vụ thành công."));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Lỗi định dạng: Vui lòng nhập giá là số hợp lệ.");
            // Forward back to form, preserving input data via ${param.field} in JSP
            String view = "add".equals(action) ? "/WEB-INF/views/add-service.jsp" : "/WEB-INF/views/edit-service.jsp";
            request.getRequestDispatcher(view).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Không thể thực hiện hành động này. Vui lòng thử lại.");
            String view = "add".equals(action) ? "/WEB-INF/views/add-service.jsp" : "/WEB-INF/views/edit-service.jsp";
            request.getRequestDispatcher(view).forward(request, response);
        }
    }
}