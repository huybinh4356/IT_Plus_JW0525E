package controller;

import model.Appointments;
import model.User;
import model.Action_Service;
import service.AppointmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/appointments/*")
public class AppointmentServlet extends HttpServlet {

    private final Logger logger = Logger.getLogger(AppointmentServlet.class.getName());
    private final AppointmentService appointmentService;

    public AppointmentServlet() {
        this.appointmentService = AppointmentService.getInstance();
    }

    private Integer getUserRoleId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object roleIdObj = session.getAttribute("userRoleId");
            if (roleIdObj instanceof Integer) {
                return (Integer) roleIdObj;
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/delete":
                    showDeleteConfirmation(request, response);
                    break;
                default:
                    listAppointment(request, response);
                    break;
            }
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Lỗi xử lý GET request", ex);
            request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
            try {
                listAppointment(request, response);
            } catch (SQLException e) {
                throw new RuntimeException("Lỗi nghiêm trọng khi cố gắng hiển thị trang danh sách.", e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getPathInfo();
        if (action == null) {
            action = "";
        }

        String redirectUrl = request.getContextPath();
        Integer userRole = getUserRoleId(request);

        if (userRole != null && userRole == 3) {
            redirectUrl += "/home";
        } else {
            redirectUrl += "/appointments";
        }

        try {
            switch (action) {
                case "/new":
                    insertAppointment(request, response);
                    break;
                case "/edit":
                    updateAppointment(request, response);
                    break;
                case "/delete":
                    deleteAppointment(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
                    return;
            }

            response.sendRedirect(redirectUrl);

        } catch (RuntimeException ex) {
            logger.log(Level.WARNING, "Lỗi nghiệp vụ/hệ thống khi xử lý POST request", ex);
            request.getSession().setAttribute("message", "Thao tác thất bại: " + ex.getMessage());
            response.sendRedirect(redirectUrl);
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Lỗi không xác định khi xử lý POST request", ex);
            request.getSession().setAttribute("message", "Lỗi không xác định: " + ex.getMessage());
            response.sendRedirect(redirectUrl);
        }
    }

    private void listAppointment(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Appointments> listAppointment = appointmentService.getAllAppointments();
        request.setAttribute("listAppointment", listAppointment);
        request.getRequestDispatcher("/WEB-INF/views/appointment-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadServicesForForm(request);
        request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Appointments existingAppointment = appointmentService.getAppointmentById(id);

            if(existingAppointment != null) {
                loadServicesForForm(request);

                request.setAttribute("appointment", existingAppointment);
                request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("message", "Không tìm thấy lịch hẹn ID: " + id);
                response.sendRedirect(request.getContextPath() + "/appointments");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "ID lịch hẹn không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/appointments");
        } catch (RuntimeException e) {
            logger.log(Level.WARNING, "Lỗi khi tìm lịch hẹn", e);
            request.getSession().setAttribute("message", "Lỗi hệ thống khi tìm lịch hẹn: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/appointments");
        }
    }

    private void showDeleteConfirmation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Appointments appointment = appointmentService.getAppointmentById(id);

            if (appointment != null) {
                request.setAttribute("appointment", appointment);
                request.getRequestDispatcher("/WEB-INF/views/appointment-delete.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("message", "Không tìm thấy lịch hẹn để xóa ID: " + id);
                response.sendRedirect(request.getContextPath() + "/appointments");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "ID lịch hẹn không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/appointments");
        } catch (RuntimeException e) {
            logger.log(Level.WARNING, "Lỗi khi tìm lịch hẹn", e);
            request.getSession().setAttribute("message", "Lỗi hệ thống khi tìm lịch hẹn: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/appointments");
        }
    }

    private void loadServicesForForm(HttpServletRequest request) {
        try {
            List<Action_Service> servicesList = appointmentService.getAllServices();
            request.setAttribute("servicesList", servicesList);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Không thể load danh sách dịch vụ.", e);
            request.setAttribute("servicesList", null);
            request.setAttribute("error", "Lỗi khi tải danh sách dịch vụ.");
        }
    }

    private void insertAppointment(HttpServletRequest request, HttpServletResponse response) {
        try {
            String code = generateUniqueCode();

            int patientId = Integer.parseInt(request.getParameter("patientId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));
            String status = request.getParameter("status");
            String note = request.getParameter("note");

            Appointments newAppointment = new Appointments();
            newAppointment.setAppointment_code(code);
            newAppointment.setAppointment_date(date);
            newAppointment.setAppointment_time(time);
            newAppointment.setStatus(status != null ? status : "PENDING");
            newAppointment.setNote(note);

            User patient = new User();
            patient.setUser_id(patientId);
            newAppointment.setPatient_id(patient);

            Action_Service service = new Action_Service();
            service.setService_id(serviceId);
            newAppointment.setService_id(service);

            if (appointmentService.addAppointment(newAppointment)) {
                request.getSession().setAttribute("message", "Đặt lịch hẹn thành công! Mã hẹn: " + code);
            } else {
                request.getSession().setAttribute("message", "Đặt lịch hẹn thất bại.");
            }
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Lỗi định dạng dữ liệu (ID không hợp lệ).", e);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Lỗi định dạng Ngày/Giờ. Vui lòng kiểm tra lại.", e);
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String code = request.getParameter("code");

            int patientId = Integer.parseInt(request.getParameter("patientId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));
            String status = request.getParameter("status");
            String note = request.getParameter("note");

            Appointments appointment = new Appointments();
            appointment.setAppointment_id(id);
            appointment.setAppointment_code(code);
            appointment.setAppointment_date(date);
            appointment.setAppointment_time(time);
            appointment.setStatus(status);
            appointment.setNote(note);

            User patient = new User();
            patient.setUser_id(patientId);
            appointment.setPatient_id(patient);

            Action_Service service = new Action_Service();
            service.setService_id(serviceId);
            appointment.setService_id(service);

            if (appointmentService.updateAppointment(appointment)) {
                request.getSession().setAttribute("message", "Cập nhật lịch hẹn thành công!");
            } else {
                request.getSession().setAttribute("message", "Cập nhật lịch hẹn thất bại.");
            }
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Lỗi định dạng dữ liệu (ID không hợp lệ).", e);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Lỗi định dạng Ngày/Giờ. Vui lòng kiểm tra lại.", e);
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            if (appointmentService.deleteAppointment(id)) {
                request.getSession().setAttribute("message", "Xóa lịch hẹn ID " + id + " thành công.");
            } else {
                request.getSession().setAttribute("message", "Xóa lịch hẹn thất bại.");
            }
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("ID lịch hẹn không hợp lệ.", e);
        }
    }

    private String generateUniqueCode() {
        String datePart = LocalDate.now().toString().replace("-", "");
        String uniqueId = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        return "AP" + datePart + "-" + uniqueId;
    }
}