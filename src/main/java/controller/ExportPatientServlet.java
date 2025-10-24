package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/export-patients")
public class ExportPatientServlet extends HttpServlet {

    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy danh sách bệnh nhân
        List<User> patients = userService.findAllPatients();

        // 2. Cấu hình HTTP Response cho việc tải file CSV
        response.setContentType("text/csv;charset=UTF-8");
        // Bắt buộc trình duyệt tải về file với tên đã đặt
        response.setHeader("Content-Disposition", "attachment; filename=\"danh_sach_benh_nhan.csv\"");

        try (PrintWriter writer = response.getWriter()) {

            // 3. Viết header của CSV (Các cột hiển thị)
            writer.println("ID,Họ Tên,Email,Số Điện Thoại,Địa Chỉ,Giới Tính,Ngày Sinh,Ngày Tạo Tài Khoản");

            // 4. Ghi dữ liệu từng dòng
            for (User patient : patients) {
                // Sử dụng String.format hoặc StringBuilder cho hiệu suất tốt hơn
                String row = String.format("%d,\"%s\",\"%s\",%s,\"%s\",%s,%s,%s",
                        patient.getUser_id(),
                        // Xử lý dấu phẩy và nháy kép trong tên
                        patient.getFull_name().replace("\"", "\"\""),
                        patient.getEmail(),
                        patient.getPhone(),
                        patient.getAddress().replace("\"", "\"\""),
                        patient.getGender(),
                        patient.getFormattedDob(),
                        patient.getFormattedCreatedAt()
                );

                writer.println(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tạo file CSV.");
        }
    }
}