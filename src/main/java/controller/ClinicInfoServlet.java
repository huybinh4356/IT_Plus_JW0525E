package controller;

import model.ClinicInfo;
import service.ClinicInfoService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/clinic-info")
public class ClinicInfoServlet extends HttpServlet {

    private final ClinicInfoService clinicInfoService = ClinicInfoService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteClinic(request, response);
                break;
            case "list":
            default:
                listClinic(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "insert":
                insertClinic(request, response);
                break;
            case "update":
                updateClinic(request, response);
                break;
            default:
                listClinic(request, response);
                break;
        }
    }

    // --- Các phương thức xử lý Logic ---

    private void listClinic(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ClinicInfo> clinicList = clinicInfoService.findAll();
        request.setAttribute("clinicList", clinicList);

        request.getRequestDispatcher("/WEB-INF/views/clinic-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 3. Sửa đường dẫn forward
        request.getRequestDispatcher("/WEB-INF/views/clinic-form.jsp").forward(request, response);
    }

    private void insertClinic(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String hostline = request.getParameter("hostline");
        String email = request.getParameter("email");
        String working_hours = request.getParameter("working_hours");
        String description = request.getParameter("description");
        String logo = request.getParameter("logo");

        ClinicInfo newClinic = new ClinicInfo(0, name, address, hostline, email,
                working_hours, description, logo);
        clinicInfoService.addClinicInfo(newClinic);

        // 4. Sửa đường dẫn redirect: Sử dụng URL mapping mới "/clinic-info"
        response.sendRedirect(request.getContextPath() + "/clinic-info?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // *Chú ý quan trọng: Bổ sung logic lấy ID và tìm kiếm đối tượng để điền vào Form!*
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            // **Yêu cầu Bổ sung vào Service/DAO:** ClinicInfo clinic = clinicInfoService.findById(id);
            // request.setAttribute("clinic", clinic);

        } catch (NumberFormatException e) {
            // Xử lý nếu ID không hợp lệ
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID phòng khám không hợp lệ.");
            return;
        }

        // 5. Sửa đường dẫn forward
        request.getRequestDispatcher("/WEB-INF/views/clinic-form.jsp").forward(request, response);
    }

    private void updateClinic(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");

        // Đảm bảo id tồn tại và là số hợp lệ
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String hostline = request.getParameter("hostline");
            String email = request.getParameter("email");
            String working_hours = request.getParameter("working_hours");
            String description = request.getParameter("description");
            String logo = request.getParameter("logo");

            ClinicInfo clinic = new ClinicInfo(id, name, address, hostline, email,
                    working_hours, description, logo);
            clinicInfoService.updateClinicInfo(clinic);
        } catch (NumberFormatException e) {
            // Xử lý nếu ID không hợp lệ
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID phòng khám không hợp lệ.");
            return;
        }

        // 6. Sửa đường dẫn redirect
        response.sendRedirect(request.getContextPath() + "/clinic-info?action=list");
    }

    private void deleteClinic(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            clinicInfoService.deleteClinicInfo(id);
        } catch (NumberFormatException e) {
            // Xử lý nếu ID không hợp lệ
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID phòng khám không hợp lệ.");
            return;
        }

        // 7. Sửa đường dẫn redirect
        response.sendRedirect(request.getContextPath() + "/clinic-info?action=list");
    }
}