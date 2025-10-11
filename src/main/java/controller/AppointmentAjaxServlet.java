package controller;

import model.Appointments;
import service.AppointmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Collections;

@WebServlet("/appointments-by-patient")
public class AppointmentAjaxServlet extends HttpServlet {

    private AppointmentService appointmentService = AppointmentService.getInstance();

    // Định dạng giờ: HH:mm
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String patientIdParam = req.getParameter("patientId");

        if (patientIdParam == null || patientIdParam.isEmpty()) {
            resp.getWriter().write("[]");
            return;
        }

        try {
            int patientId = Integer.parseInt(patientIdParam);

            // Lấy danh sách lịch hẹn từ Service
            List<Appointments> appointments = appointmentService.getAppointmentsByPatient(patientId);

            // Xây dựng chuỗi JSON
            StringBuilder json = new StringBuilder("[");

            for (int i = 0; i < appointments.size(); i++) {
                Appointments app = appointments.get(i);
                if (i > 0) json.append(",");

                // ⭐ XỬ LÝ VÀ FORMAT DỮ LIỆU ĐỂ HIỂN THỊ ⭐

                // Ngày: YYYY-MM-DD
                String dateString = app.getAppointment_date() != null ? app.getAppointment_date().toString() : "";

                // Giờ: HH:mm
                String timeString = "";
                LocalTime appTime = app.getAppointment_time();
                if (appTime != null) {
                    timeString = appTime.format(TIME_FORMATTER);
                }

                // Mã lịch hẹn
                String code = app.getAppointment_code() != null ? app.getAppointment_code() : "";

                json.append("{")
                        .append("\"appointment_id\":").append(app.getAppointment_id()).append(",")
                        // Gộp Ngày và Giờ để tiện hiển thị trên JSP
                        .append("\"appointment_date\":\"").append(dateString).append(" ").append(timeString).append("\",")
                        .append("\"appointment_code\":\"").append(code).append("\"")
                        .append("}");
            }

            json.append("]");

            resp.getWriter().write(json.toString());

        } catch (NumberFormatException e) {
            resp.getWriter().write("[]");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Lỗi server khi tải lịch hẹn\"}");
        }
    }
}