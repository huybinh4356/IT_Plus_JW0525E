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

    /**
     * Lấy Role ID từ Session.
     */
    private Integer getRoleId(HttpServletRequest request) {
        Object roleIdObj = request.getSession().getAttribute("userRoleId");
        if (roleIdObj instanceof Integer) {
            return (Integer) roleIdObj;
        }
        return null;
    }

    /**
     * Kiểm tra xem người dùng có phải là Admin (Role ID 1) hay không.
     * Chỉ Admin mới được thực hiện các thao tác CRUD nhạy cảm và xem danh sách đầy đủ.
     */
    private boolean isAdmin(HttpServletRequest request) {
        Integer roleId = getRoleId(request);
        return roleId != null && roleId == 1;
    }

    // =================================================================
    // DO GET
    // =================================================================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userRoleId = getRoleId(request);
        Integer currentUserId = (Integer) session.getAttribute("userId");

        // 1. Kiểm tra đăng nhập
        if (userRoleId == null || currentUserId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        // 2. LOGIC CHẶN CÁC THAO TÁC CRUD NẾU KHÔNG PHẢI ADMIN (Role 1)

        // Các action nhạy cảm: addForm, editForm, delete.
        // Action 'list' được xử lý khác vì Role 2, 3 được phép truy cập nhưng sẽ bị lọc dữ liệu.
        if (("addForm".equals(action) || "editForm".equals(action) || "delete".equals(action))) {
            if (userRoleId != 1) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện chức năng này.");
                return;
            }
        }

        // 3. ADMIN ĐƯỢC PHÉP THỰC HIỆN TẤT CẢ, ROLE 2, 3 CHỈ ĐƯỢC VIEW CHI TIẾT VÀ LIST (CÓ LỌC)

        try {
            switch (action) {
                case "addForm":
                    showAddForm(request, response); // Chỉ Admin
                    break;
                case "editForm":
                    showEditForm(request, response); // Chỉ Admin
                    break;
                case "detail":
                    viewUser(request, response); // Tất cả các Role
                    break;
                case "delete":
                    deleteUser(request, response); // Chỉ Admin
                    break;
                case "list":
                default:
                    listUsers(request, response); // Tất cả các Role (Role 2, 3 sẽ bị lọc dữ liệu)
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
        }
    }

    // =================================================================
    // DO POST
    // =================================================================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Chặn tất cả thực hiện POST (Thêm/Sửa/Xóa) nếu KHÔNG phải Admin.
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
                    updateUser(request, response);
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
    /**
     * Lọc danh sách người dùng hiển thị dựa trên vai trò (Role).
     * Role 1 (Admin) -> Xem tất cả.
     * Role 2 (Bác sĩ) & Role 3 (Bệnh nhân) -> Chỉ xem hồ sơ của chính họ.
     */
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userRoleId = (Integer) session.getAttribute("userRoleId");
        Integer currentUserId = (Integer) session.getAttribute("userId");

        List<User> list;

        if (userRoleId != null && userRoleId == 1) {
            // Role 1 (Admin): Lấy tất cả người dùng và áp dụng tìm kiếm
            String searchType = request.getParameter("searchType");
            String keyword = request.getParameter("keyword");

            if (searchType != null && !searchType.isEmpty() && keyword != null && !keyword.isEmpty()) {
                // Giả định bạn có hàm tìm kiếm trong service
                list = userService.searchUsers(searchType, keyword);
            } else {
                list = userService.getAllUsers();
            }
        } else if (userRoleId != null && (userRoleId == 2 || userRoleId == 3)) {
            // Role 2 (Bác sĩ) hoặc Role 3 (Bệnh nhân): Chỉ lấy hồ sơ của chính họ
            User selfUser = userService.findById(currentUserId);
            list = new ArrayList<>();
            if (selfUser != null) {
                list.add(selfUser);
            }
            // Không thực hiện tìm kiếm cho Role 2, 3 vì họ chỉ thấy 1 record
        } else {
            // Trường hợp lỗi hoặc Role không xác định
            list = new ArrayList<>();
        }

        request.setAttribute("users", list);
        request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
    }
    // ----------------------------------------------------------------------
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ Admin được truy cập
        List<Specialties> specialties = specialtiesService.findAll();
        request.setAttribute("specialties", specialties);
        request.setAttribute("user", new User());
        request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
    }

    // ----------------------------------------------------------------------
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ Admin được truy cập
        int id = parseId(request, response);
        if (id == -1) return;

        User user = userService.findById(id);
        List<Specialties> specialties = specialtiesService.findAll();

        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("specialties", specialties);
            request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
        } else {
            response.sendRedirect("users?error=User_not_found");
        }
    }

    // ----------------------------------------------------------------------
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tất cả các Role đều có thể xem chi tiết
        int targetUserId = parseId(request, response);
        if (targetUserId == -1) return;

        HttpSession session = request.getSession();
        Integer viewerRoleId = (Integer) session.getAttribute("userRoleId");
        Integer currentUserId = (Integer) session.getAttribute("userId");

        // Phân quyền: Role 2, 3 chỉ được xem hồ sơ của chính mình
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
            response.sendRedirect("users?error=User_not_found");
        }
    }

    // ----------------------------------------------------------------------
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ Admin được truy cập
        String username = request.getParameter("username");

        if (userService.isUsernameExists(username)) {
            setFormDataAttributes(request);
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại. Vui lòng chọn tên khác.");
            request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
            return;
        }

        User user = buildUserFromRequest(request);
        user.setPassword_hash(request.getParameter("password_hash"));

        boolean isAdded = userService.addUser(user);

        if (isAdded) {
            response.sendRedirect("users?message=add_success");
        } else {
            setFormDataAttributes(request);
            request.setAttribute("error", "Đã xảy ra lỗi khi thêm người dùng. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/add-user.jsp").forward(request, response);
        }
    }

    // ----------------------------------------------------------------------
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // Chỉ Admin được truy cập
        try {
            int userId = parseId(request, response);
            if (userId == -1) return;

            User user = buildUserFromRequest(request);
            user.setUser_id(userId);

            String newPassword = request.getParameter("password_hash");
            if (newPassword != null && !newPassword.isEmpty()) {
                user.setPassword_hash(newPassword);
            } else {
                user.setPassword_hash(null); // Giữ lại mật khẩu cũ nếu không nhập mới
            }

            boolean isUpdated = userService.updateUser(user);

            if (isUpdated) {
                response.sendRedirect("users?message=update_success");
            } else {
                request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật người dùng.");
                request.setAttribute("user", user);
                request.setAttribute("specialties", specialtiesService.findAll());
                request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            setFormDataAttributes(request);
            request.getRequestDispatcher("/WEB-INF/views/edit-user.jsp").forward(request, response);
        }
    }

    // ----------------------------------------------------------------------
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Chỉ Admin được truy cập
        int id = parseId(request, response);
        if (id == -1) return;

        userService.deleteUser(id);
        response.sendRedirect("users?message=delete_success");
    }

    // ----------------------------------------------------------------------
    /**
     * Phương thức tiện ích để phân tích ID từ request parameter.
     */
    private int parseId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            // Trong trường hợp này, không chuyển hướng mà chỉ trả về -1 để logic gọi xử lý
            return -1;
        }
        try {
            return Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("users?error=Invalid_id_format");
            return -1;
        }
    }

    // ----------------------------------------------------------------------
    /**
     * Phương thức tiện ích để thiết lập lại các thuộc tính dữ liệu form (ví dụ: khi có lỗi nhập).
     */
    private void setFormDataAttributes(HttpServletRequest request) {
        List<Specialties> specialties = specialtiesService.findAll();
        request.setAttribute("specialties", specialties);

        User tempUser = buildUserFromRequest(request);

        if ("update".equals(request.getParameter("action")) && request.getParameter("id") != null) {
            try {
                tempUser.setUser_id(Integer.parseInt(request.getParameter("id")));
            } catch (NumberFormatException e) { /* Bỏ qua lỗi parse */ }
        }

        request.setAttribute("user", tempUser);
    }

    // ----------------------------------------------------------------------
    /**
     * Phương thức tiện ích để xây dựng đối tượng User từ request parameters.
     */
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