package controller;

import model.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Tên đăng nhập và Mật khẩu.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        User authenticatedUser = null;
        try {
            authenticatedUser = userService.authenticate(username, password);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống trong quá trình đăng nhập.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();

            session.setAttribute("user", authenticatedUser);

            session.setAttribute("userId", authenticatedUser.getUser_id());

            int roleId = authenticatedUser.getRole_id();
            // Lưu dưới dạng Integer để đảm bảo việc so sánh trong JSP là số học
            session.setAttribute("userRoleId", Integer.valueOf(roleId));
            String roleString;
            switch (roleId) {
                case 1:
                    roleString = "ADMIN";
                    break;
                case 2:
                    roleString = "DOCTOR";
                    break;
                case 3:
                default:
                    roleString = "PATIENT";
                    break;
            }
            session.setAttribute("userRole", roleString);

            response.sendRedirect(request.getContextPath() + "/home");

        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}