package controller;

import model.User;
import model.Specialties;
import service.UserService;
import service.SpecialtiesService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private final UserService userService = UserService.getInstance();
    private final SpecialtiesService specialtiesService = SpecialtiesService.getInstance();

    private Integer getRoleId(HttpServletRequest request) {
        Object roleIdObj = request.getSession().getAttribute("userRoleId");
        if (roleIdObj instanceof Integer) {
            return (Integer) roleIdObj;
        }
        return null;
    }

    private boolean isAdmin(HttpServletRequest request) {
        Integer roleId = getRoleId(request);
        return roleId != null && roleId == 1;
    }

    // Hàm tiện ích chuyển hướng với thông báo
    private void sendRedirectWithMessage(HttpServletResponse response, String url, String message, boolean isError) throws IOException {
        String separator = url.contains("?") ? "&" : "?";
        String type = isError ? "error" : "message";
        String encodedMessage = java.net.URLEncoder.encode(message, java.nio.charset.StandardCharsets.UTF_8.toString());
        response.sendRedirect(url + separator + type + "=" + encodedMessage);
    }

    // =================================================================
    // DO GET (Không thay đổi logic chính)
    // =================================================================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userRoleId = getRoleId(request);
        Integer currentUserId = (Integer) session.getAttribute("userId");
        String contextPath = request.getContextPath();

        if (userRoleId == null || currentUserId == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        if (("addForm".equals(action) || "editForm".equals(action) || "delete".equals(action))) {
            if (userRoleId != 1) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện chức năng này.");
                return;
            }
        }

        try {
            switch (action) {
                case "addForm":
                    showAddForm(request, response);
                    break;
                case "editForm":
                    showEditForm(request, response);
                    break;
                case "detail":
                    viewUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "list":
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
        }
    }

    // =================================================================
    // DO POST (Không thay đổi logic chính)
    // =================================================================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện chức năng này.");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "add":
                    insertUser(request, response);
                    break;
                case "update":
                    updateUser(request, response); // LOGIC CHÍNH ĐÃ SỬA
                    break;
                default:
                    response.sendRedirect("users");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
        }
    }

    // ----------------------------------------------------------------------
    // Các phương thức khác (listUsers, showAddForm, showEditForm, viewUser, insertUser)
    // Giữ nguyên hoặc chỉ thay đổi chút ít
    // ----------------------------------------------------------------------

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userRoleId = (Integer) session.getAttribute("userRoleId");
        Integer currentUserId = (Integer) session.getAttribute("userId");

        List<User> list;

        if (userRoleId != null && userRoleId == 1) {
            String searchType = request.getParameter("searchType");
            String keyword = request.getParameter("keyword");

            if (searchType != null && !searchType.isEmpty() && keyword != null && !keyword.isEmpty()) {
                list = userService.searchUsers(searchType, keyword);
            } else {
                list = userService.getAllUsers();
            }
        } else if (userRoleId != null && (userRoleId == 2 || userRoleId == 3)) {
            User selfUser = userService.findById(currentUserId);
            list = new ArrayList<>();
            if (selfUser != null) {
                list.add(selfUser);
            }
        } else {
            list = new ArrayList<>();
        }

        request.setAttribute("users", list);
        request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Specialties> specialties = specialtiesService.findAll();
        request.setAttribute("specialties", specialties);
        // Kiểm tra nếu có dữ liệu lỗi cũ từ forward
        if (request.getAttribute("user") == null) {
            request.setAttribute("user", new User());
        }
        request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request, response);
        if (id == -1) return;

        User user = userService.findById(id);
        List<Specialties> specialties = specialtiesService.findAll();

        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("specialties", specialties);
            request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
        } else {
            sendRedirectWithMessage(response, "users", "Không tìm thấy người dùng ID: " + id, true);
        }
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int targetUserId = parseId(request, response);
        if (targetUserId == -1) return;

        HttpSession session = request.getSession();
        Integer viewerRoleId = (Integer) session.getAttribute("userRoleId");
        Integer currentUserId = (Integer) session.getAttribute("userId");

        if ((viewerRoleId == 2 || viewerRoleId == 3) && targetUserId != currentUserId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem hồ sơ người dùng khác.");
            return;
        }

        User user = userService.findById(targetUserId);
        if (user != null) {
            request.setAttribute("viewerRoleId", viewerRoleId);
            request.setAttribute("currentUserId", currentUserId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user-detail.jsp").forward(request, response);
        } else {
            sendRedirectWithMessage(response, "users", "Không tìm thấy người dùng chi tiết.", true);
        }
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (userService.isUsernameExists(username)) {
            setFormDataAttributes(request); // Giữ lại dữ liệu đã nhập
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại. Vui lòng chọn tên khác.");
            request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
            return;
        }

        User user = buildUserFromRequest(request);
        user.setPassword_hash(request.getParameter("password_hash"));

        boolean isAdded = userService.addUser(user);

        if (isAdded) {
            sendRedirectWithMessage(response, "users", "Thêm người dùng thành công.", false);
        } else {
            setFormDataAttributes(request);
            request.setAttribute("error", "Đã xảy ra lỗi khi thêm người dùng. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
        }
    }

    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC ĐÃ SỬA LỖI: ĐẢM BẢO ID VÀ FORM DATA ĐƯỢC GIỮ LẠI KHI CÓ LỖI
    // ----------------------------------------------------------------------
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // Chỉ Admin được truy cập
        int userId = 0;
        try {
            userId = parseId(request, response);
            if (userId == -1) return; // Đã chuyển hướng trong parseId

            // Tải dữ liệu từ Request và áp dụng lên một đối tượng User mới
            User userUpdateData = buildUserFromRequest(request);
            userUpdateData.setUser_id(userId);

            // Xử lý mật khẩu
            String newPassword = request.getParameter("password_hash");
            if (newPassword != null && !newPassword.isEmpty()) {
                userUpdateData.setPassword_hash(newPassword);
            } else {
                userUpdateData.setPassword_hash(null); // Giữ lại mật khẩu cũ nếu null
            }

            boolean isUpdated = userService.updateUser(userUpdateData);

            if (isUpdated) {
                sendRedirectWithMessage(response, "users?action=detail&id=" + userId, "Cập nhật người dùng thành công.", false);
            } else {
                // Lỗi cập nhật DB thất bại (ví dụ: duplicate key, lỗi kết nối)
                request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật người dùng. Vui lòng thử lại.");
                // Tái tải dữ liệu cho form
                setFormDataAttributes(request);
                request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Lỗi ID không hợp lệ (xảy ra khi gọi parseId)
            sendRedirectWithMessage(response, "users", "Lỗi ID người dùng không hợp lệ.", true);
        } catch (Exception e) {
            e.printStackTrace();
            // Lỗi khác (ví dụ: lỗi parse LocalDate trong buildUserFromRequest)
            request.setAttribute("error", "Lỗi: Dữ liệu không hợp lệ. Vui lòng kiểm tra lại định dạng Ngày sinh/Role/Chuyên môn.");
            // Tái tải dữ liệu cho form, sử dụng dữ liệu request hiện tại
            setFormDataAttributes(request);
            request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
        }
    }

    // ----------------------------------------------------------------------
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = parseId(request, response);
        if (id == -1) return;

        try {
            userService.deleteUser(id);
            sendRedirectWithMessage(response, "users", "Xóa người dùng ID " + id + " thành công.", false);
        } catch (Exception e) {
            e.printStackTrace();
            sendRedirectWithMessage(response, "users", "Lỗi khi xóa người dùng ID " + id + ". Vui lòng kiểm tra ràng buộc.", true);
        }
    }

    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC ĐÃ SỬA LỖI: ĐẢM BẢO ID ĐƯỢC PHÂN TÍCH ĐÚNG CÁCH CHO EDIT FORM
    // ----------------------------------------------------------------------
    private int parseId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Lấy ID từ tham số 'id' (GET: showEditForm, delete) hoặc 'user_id' (POST: updateUser)
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("user_id"); // Giả định form POST có trường user_id
        }

        if (idParam == null || idParam.isEmpty()) {
            // Nếu không tìm thấy ID, chuyển hướng về danh sách
            sendRedirectWithMessage(response, "users", "Thiếu ID người dùng cần xử lý.", true);
            return -1;
        }
        try {
            return Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            sendRedirectWithMessage(response, "users", "ID người dùng không hợp lệ.", true);
            return -1;
        }
    }

    // ----------------------------------------------------------------------
    // PHƯƠNG THỨC ĐÃ SỬA LỖI: TÁI TẠO DỮ LIỆU ĐÚNG CÁCH CHO FORM LỖI
    // ----------------------------------------------------------------------
    private void setFormDataAttributes(HttpServletRequest request) {
        List<Specialties> specialties = specialtiesService.findAll();
        request.setAttribute("specialties", specialties);

        User tempUser = buildUserFromRequest(request);

        // Đảm bảo user_id được đặt lại cho form chỉnh sửa
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("user_id");
        }

        if (idParam != null && !idParam.isEmpty()) {
            try {
                tempUser.setUser_id(Integer.parseInt(idParam));
            } catch (NumberFormatException e) { /* Bỏ qua lỗi parse */ }
        }

        request.setAttribute("user", tempUser);
    }

    // ----------------------------------------------------------------------
    // Giữ nguyên buildUserFromRequest
    // ----------------------------------------------------------------------
    private User buildUserFromRequest(HttpServletRequest request) {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setFull_name(request.getParameter("full_name"));

        String dob = request.getParameter("dob");
        if (dob != null && !dob.isEmpty()) {
            try {
                user.setDob(LocalDate.parse(dob));
            } catch (Exception e) { /* Bỏ qua lỗi parse */ }
        }

        user.setGender(request.getParameter("gender"));
        user.setCccd(request.getParameter("cccd"));
        user.setPhone(request.getParameter("phone"));
        user.setEmail(request.getParameter("email"));
        user.setAddress(request.getParameter("address"));

        String roleParam = request.getParameter("role_id");
        if (roleParam != null && !roleParam.isEmpty()) {
            try {
                user.setRole_id(Integer.parseInt(roleParam));
            } catch (NumberFormatException e) { /* Bỏ qua lỗi parse */ }
        }

        String specialtyParam = request.getParameter("specialty_id");
        if (specialtyParam != null && !specialtyParam.isEmpty()) {
            try {
                Specialties sp = new Specialties();
                sp.setSpecialtyId(Integer.parseInt(specialtyParam));
                user.setSpecialty(sp);
            } catch (NumberFormatException e) { /* Bỏ qua lỗi parse */ }
        }

        user.setDegree(request.getParameter("degree"));
        user.setPosition(request.getParameter("position"));

        String isActive = request.getParameter("is_active");
        user.setIs_active("on".equals(isActive) || "true".equals(isActive) || "1".equals(isActive));

        return user;
    }
}