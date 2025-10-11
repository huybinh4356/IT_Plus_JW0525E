package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Specialties;
import service.SpecialtiesService;

import java.io.IOException;
import java.util.List;

@WebServlet("/specialties")
public class SpecialtiesServlet extends HttpServlet {
    private final SpecialtiesService specialtiesService = SpecialtiesService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "addForm":
                request.getRequestDispatcher("/WEB-INF/views/add-specialty.jsp").forward(request, response);
                break;

            case "editForm":
                // BẮT ĐẦU PHẦN SỬA LỖI ĐỊNH TUYẾN KHI EDIT
                try {
                    String idParam = request.getParameter("id");
                    if (idParam == null || idParam.isEmpty()) {
                        // Trường hợp 1: Thiếu ID. Chuyển hướng về danh sách với thông báo lỗi.
                        response.sendRedirect(request.getContextPath() + "/specialties?error=invalid_id");
                        return;
                    }

                    int id = Integer.parseInt(idParam);
                    Specialties specialty = specialtiesService.findById(id);

                    if (specialty != null) {
                        // Trường hợp 2: Tìm thấy chuyên khoa. Forward đến trang edit.
                        request.setAttribute("specialty", specialty);
                        request.getRequestDispatcher("/WEB-INF/views/edit-specialty.jsp").forward(request, response);
                    } else {
                        // Trường hợp 3: ID hợp lệ nhưng không tìm thấy chuyên khoa trong DB.
                        response.sendRedirect(request.getContextPath() + "/specialties?error=not_found");
                    }
                } catch (NumberFormatException e) {
                    // Trường hợp 4: ID không phải là số nguyên.
                    response.sendRedirect(request.getContextPath() + "/specialties?error=invalid_id_format");
                } catch (Exception e) {
                    // Trường hợp 5: Các lỗi khác (ví dụ: lỗi DB).
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/specialties?error=db_error");
                }
                break;
            // KẾT THÚC PHẦN SỬA LỖI ĐỊNH TUYẾN KHI EDIT

            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    specialtiesService.deleteSpecialty(deleteId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                // Sử dụng getContextPath() cho redirect để đảm bảo URL tuyệt đối
                response.sendRedirect(request.getContextPath() + "/specialties");
                break;

            default: // list + search
                String searchType = request.getParameter("searchType");
                String keyword = request.getParameter("keyword");

                List<Specialties> specialties;
                if (searchType != null && keyword != null && !keyword.isBlank()) {
                    switch (searchType) {
                        case "name":
                            specialties = specialtiesService.findByName(keyword);
                            break;
                        case "description":
                            specialties = specialtiesService.findByDescription(keyword);
                            break;
                        default:
                            specialties = specialtiesService.findAll();
                    }
                } else {
                    specialties = specialtiesService.findAll();
                }

                request.setAttribute("specialties", specialties);
                request.getRequestDispatcher("/WEB-INF/views/specialty-list.jsp").forward(request, response);
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

        try {
            if ("add".equals(action)) {
                Specialties specialty = new Specialties();
                specialty.setName(request.getParameter("name"));
                specialty.setDescription(request.getParameter("description"));
                specialtiesService.addSpecialty(specialty);

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Specialties specialty = new Specialties();
                specialty.setSpecialtyId(id);
                specialty.setName(request.getParameter("name"));
                specialty.setDescription(request.getParameter("description"));
                specialtiesService.updateSpecialty(specialty);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Sử dụng getContextPath() cho redirect để đảm bảo URL tuyệt đối
        response.sendRedirect(request.getContextPath() + "/specialties");
    }
}