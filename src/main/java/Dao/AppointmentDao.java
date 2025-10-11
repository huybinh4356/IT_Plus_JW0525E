package Dao;

import Dao.MySql_JDBC.Connection_DreamTooth;
import model.Appointments;
import model.User;
import model.Action_Service;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppointmentDao {

    private static final Logger logger = Logger.getLogger(AppointmentDao.class.getName());

    private static AppointmentDao appointmentDao;

    // 1. Hàm tạo Private
    private AppointmentDao() {
        // Khởi tạo rỗng
    }

    // 2. Phương thức getInstance()
    public static AppointmentDao getInstance() {
        if (appointmentDao == null) {
            appointmentDao = new AppointmentDao();
        }
        return appointmentDao;
    }

    // 3. Phương thức helper để lấy Connection
    private Connection getConnection() throws SQLException {
        // Giả định Connection_DreamTooth.getConnection() là phương thức static
        return Connection_DreamTooth.getConnection();
    }

    // Query cơ bản (Giả định bạn đã tạo join với action_service và đặt tên là s)
    private final String BASE_SELECT_SQL =
            "SELECT a.*, up.full_name as patient_name " +
                    "FROM appointments a " +
                    "INNER JOIN users up ON a.patient_id = up.user_id ";
    // Nếu muốn thêm tên dịch vụ, uncomment dòng dưới:
    // "INNER JOIN action_service s ON a.service_id = s.service_id ";

    // CREATE - Thêm lịch hẹn mới (Không thay đổi)
    public boolean addAppointment(Appointments appointment) {
        // SQL: 8 cột (appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note, created_at)
        String sql = "INSERT INTO appointments (appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, appointment.getAppointment_code());
            stmt.setInt(2, appointment.getPatient_id().getUser_id());

            // Tham số 3: service_id
            stmt.setInt(3, appointment.getService_id().getService_id());

            // Tham số 4-8: date, time, status, note, created_at
            stmt.setDate(4, Date.valueOf(appointment.getAppointment_date()));
            stmt.setTime(5, Time.valueOf(appointment.getAppointment_time()));
            stmt.setString(6, appointment.getStatus().toUpperCase());
            stmt.setString(7, appointment.getNote());
            stmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        appointment.setAppointment_id(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi thêm lịch hẹn", e);
            throw new RuntimeException("Lỗi DB khi thêm lịch hẹn.", e);
        } catch (NullPointerException e) {
            logger.log(Level.SEVERE, "Lỗi NullPointer: patient_id hoặc service_id chưa được thiết lập.", e);
            throw new RuntimeException("Dữ liệu Foreign Key không hợp lệ.", e);
        }
        return false;
    }

    // READ - Lấy tất cả lịch hẹn (Không thay đổi)
    public List<Appointments> findAll() {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                appointments.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi lấy danh sách lịch hẹn", e);
            throw new RuntimeException("Lỗi DB khi lấy danh sách lịch hẹn.", e);
        }
        return appointments;
    }

    // READ - Lấy lịch hẹn theo ID (Không thay đổi)
    public Appointments findById(int appointmentId) {
        String sql = BASE_SELECT_SQL + " WHERE a.appointment_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAppointment(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo ID: " + appointmentId, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo ID.", e);
        }
        return null;
    }

    // READ - Tìm kiếm theo mã lịch hẹn (Không thay đổi)
    public Appointments findByAppointmentCode(String appointmentCode) {
        String sql = BASE_SELECT_SQL + " WHERE a.appointment_code = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, appointmentCode);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAppointment(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo mã: " + appointmentCode, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo mã.", e);
        }
        return null;
    }

    // READ - Tìm kiếm theo patient_id (bệnh nhân) (Không thay đổi)
    public List<Appointments> findByPatientId(int patientId) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.patient_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo patient_id: " + patientId, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo patient_id.", e);
        }
        return appointments;
    }

    // READ - Tìm kiếm theo service_id (Không thay đổi)
    public List<Appointments> findByServiceId(int serviceId) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.service_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo service_id: " + serviceId, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo service_id.", e);
        }
        return appointments;
    }

    // READ - Tìm kiếm theo ngày hẹn (Không thay đổi)
    public List<Appointments> findByAppointmentDate(LocalDate date) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.appointment_date = ? ORDER BY a.appointment_time ASC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, Date.valueOf(date));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo ngày: " + date, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo ngày.", e);
        }
        return appointments;
    }

    // READ - Tìm kiếm theo thời gian hẹn (Không thay đổi)
    public List<Appointments> findByAppointmentTime(LocalTime time) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.appointment_time = ? ORDER BY a.appointment_date DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTime(1, Time.valueOf(time));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo thời gian: " + time, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo thời gian.", e);
        }
        return appointments;
    }

    // READ - Tìm kiếm theo ngày và bệnh nhân (Không thay đổi)
    public List<Appointments> findByDateAndPatient(LocalDate date, int patientId) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.appointment_date = ? AND a.patient_id = ? ORDER BY a.appointment_time ASC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, Date.valueOf(date));
            stmt.setInt(2, patientId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo ngày và bệnh nhân", e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo ngày và bệnh nhân.", e);
        }
        return appointments;
    }

    // READ - Tìm kiếm theo trạng thái (Không thay đổi)
    public List<Appointments> findByStatus(String status) {
        List<Appointments> appointments = new ArrayList<>();
        String sql = BASE_SELECT_SQL + " WHERE a.status = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Đảm bảo tìm kiếm theo UPPERCASE để khớp với ENUM
            stmt.setString(1, status.toUpperCase());

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi tìm lịch hẹn theo trạng thái: " + status, e);
            throw new RuntimeException("Lỗi DB khi tìm lịch hẹn theo trạng thái.", e);
        }
        return appointments;
    }

    // UPDATE - Cập nhật lịch hẹn (Không thay đổi)
    public boolean updateAppointment(Appointments appointment) {
        // SQL: 7 cột được UPDATE (appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note)
        String sql = "UPDATE appointments SET appointment_code = ?, patient_id = ?, service_id = ?, " +
                "appointment_date = ?, appointment_time = ?, status = ?, note = ? " +
                "WHERE appointment_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, appointment.getAppointment_code());
            stmt.setInt(2, appointment.getPatient_id().getUser_id());

            // Tham số 3: service_id
            stmt.setInt(3, appointment.getService_id().getService_id());

            // Tham số 4-7: date, time, status, note
            stmt.setDate(4, Date.valueOf(appointment.getAppointment_date()));
            stmt.setTime(5, Time.valueOf(appointment.getAppointment_time()));
            stmt.setString(6, appointment.getStatus().toUpperCase());
            stmt.setString(7, appointment.getNote());

            // Tham số 8: appointment_id (WHERE clause)
            stmt.setInt(8, appointment.getAppointment_id());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi cập nhật lịch hẹn ID: " + appointment.getAppointment_id(), e);
            throw new RuntimeException("Lỗi DB khi cập nhật lịch hẹn.", e);
        } catch (NullPointerException e) {
            logger.log(Level.SEVERE, "Lỗi NullPointer: FKs chưa được thiết lập khi cập nhật.", e);
            throw new RuntimeException("Dữ liệu Foreign Key không hợp lệ khi cập nhật.", e);
        }
    }

    // UPDATE - Cập nhật trạng thái lịch hẹn (Không thay đổi)
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Cập nhật status dưới dạng UPPERCASE
            stmt.setString(1, status.toUpperCase());
            stmt.setInt(2, appointmentId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi cập nhật trạng thái lịch hẹn ID: " + appointmentId, e);
            throw new RuntimeException("Lỗi DB khi cập nhật trạng thái.", e);
        }
    }

    // DELETE - Xóa lịch hẹn (Không thay đổi)
    public boolean deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM appointments WHERE appointment_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi xóa lịch hẹn ID: " + appointmentId, e);
            throw new RuntimeException("Lỗi DB khi xóa lịch hẹn.", e);
        }
    }

    // ⭐ PHƯƠNG THỨC NÀY ĐÃ ĐƯỢC SỬA LỖI XỬ LÝ NULL ⭐
    private Appointments mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointments appointment = new Appointments();
        appointment.setAppointment_id(rs.getInt("appointment_id"));
        appointment.setAppointment_code(rs.getString("appointment_code"));

        // 1. Ánh xạ User (Patient)
        User patient = new User();
        patient.setUser_id(rs.getInt("patient_id"));
        try {
            patient.setFull_name(rs.getString("patient_name"));
        } catch (SQLException ignored) { /* Bỏ qua nếu cột không tồn tại */ }
        appointment.setPatient_id(patient);

        // 2. Ánh xạ Service (Chỉ ID)
        Action_Service service = new Action_Service();
        service.setService_id(rs.getInt("service_id"));
        appointment.setService_id(service);

        // 3. Xử lý NULL cho Date và Time
        Date sqlDate = rs.getDate("appointment_date");
        if (sqlDate != null) {
            appointment.setAppointment_date(sqlDate.toLocalDate());
        }

        Time sqlTime = rs.getTime("appointment_time");
        if (sqlTime != null) {
            appointment.setAppointment_time(sqlTime.toLocalTime());
        }

        appointment.setStatus(rs.getString("status"));
        appointment.setNote(rs.getString("note"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            appointment.setCreated_at(createdAt.toLocalDateTime());
        }

        return appointment;
    }

    // Kiểm tra xem thời gian đã được đặt chưa (tránh trùng lịch của cùng một bệnh nhân)
    public boolean isTimeSlotAvailable(LocalDate date, LocalTime time, int patientId) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE appointment_date = ? AND appointment_time = ? AND patient_id = ? AND status != 'CANCELLED' AND status != 'COMPLETED'";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, Date.valueOf(date));
            stmt.setTime(2, Time.valueOf(time));
            stmt.setInt(3, patientId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lỗi khi kiểm tra khung giờ", e);
            throw new RuntimeException("Lỗi truy cập DB khi kiểm tra khung giờ.", e);
        }
        return false;
    }

    // Phương thức này là duplicate của findByPatientId, nên chỉ cần giữ lại một
    public List<Appointments> getAppointmentsByPatientId(int patientId) {
        return findByPatientId(patientId);
    }
}