package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String recoveryInput = request.getParameter("recoveryInput"); // Lấy giá trị từ form
        boolean success = true;
        if (success) {
            request.setAttribute("message",
                    "Đã gửi yêu cầu khôi phục thành công! Vui lòng kiểm tra email của bạn (bao gồm cả thư mục Spam) và làm theo hướng dẫn. Vui lòng chờ.");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc Email này không tồn tại trong hệ thống.");
            request.setAttribute("recoveryInput", recoveryInput);
        }

        // CHUYỂN TIẾP (FORWARD) LẠI TRANG JSP để hiển thị thông báo và các liên hệ hỗ trợ
        request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }
}