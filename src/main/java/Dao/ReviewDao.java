package Dao;

import Dao.MySql_JDBC.Connection_DreamTooth;
import model.Appointments;
import model.Reviews;
import model.User;
import model.Action_Service;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReviewDao {
    private static ReviewDao reviewDao;

    private final String FIND_ALL =
            "SELECT review_id, patient_id, service_id, appointment_id, rating, comment, created_at FROM Reviews";
    private final String FIND_BY_ID = FIND_ALL + " WHERE review_id = ?";
    private final String FIND_BY_PATIENT_ID = FIND_ALL + " WHERE patient_id = ?";
    private final String FIND_BY_RATING = FIND_ALL + " WHERE rating = ?";
    private final String FIND_BY_SERVICE_ID = FIND_ALL + " WHERE service_id = ?";
    private final String ADD_REVIEW =
            "INSERT INTO Reviews (patient_id, service_id, appointment_id, rating, comment, created_at) VALUES (?, ?, ?, ?, ?, ?)";
    private final String UPDATE_REVIEW =
            "UPDATE Reviews SET service_id = ?, appointment_id = ?, rating = ?, comment = ? WHERE review_id = ?";
    private final String DELETE_REVIEW = "DELETE FROM Reviews WHERE review_id = ?";

    // SQL cho Lịch hẹn
    private final String FIND_APPOINTMENTS_BY_PATIENT =
            "SELECT appointment_id, appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note, created_at FROM Appointments WHERE patient_id = ?";

    // SQL cho Dịch vụ (Đã sửa tên bảng thành Services và tối ưu hóa truy vấn)
    private final String FIND_SERVICES_BY_PATIENT =
            "SELECT DISTINCT s.service_id, s.service_name " +
                    "FROM Services s " +
                    "JOIN Appointments a ON s.service_id = a.service_id " + // Join trực tiếp
                    "WHERE a.patient_id = ?";


    private ReviewDao() {}

    public static ReviewDao getInstance() {
        if (reviewDao == null) {
            reviewDao = new ReviewDao();
        }
        return reviewDao;
    }

    private Connection getConnection() throws SQLException {
        return Connection_DreamTooth.getConnection();
    }

    // ================= CRUD =================

    public Reviews findById(int review_id) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {
            ps.setInt(1, review_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReview(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm review theo id: " + review_id, e);
        }
        return null;
    }

    public List<Reviews> findAll() {
        List<Reviews> reviews = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                reviews.add(mapResultSetToReview(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy tất cả reviews", e);
        }
        return reviews;
    }

    public List<Reviews> findByPatientId(int patient_id) {
        List<Reviews> reviews = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_PATIENT_ID)) {
            ps.setInt(1, patient_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm review theo patient_id: " + patient_id, e);
        }
        return reviews;
    }

    public List<Reviews> findByRating(int rating) {
        List<Reviews> reviews = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_RATING)) {
            ps.setInt(1, rating);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm review theo rating: " + rating, e);
        }
        return reviews;
    }

    public List<Reviews> findByServiceId(int service_id) {
        List<Reviews> reviews = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(FIND_BY_SERVICE_ID)) {
            ps.setInt(1, service_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm review theo service_id: " + service_id, e);
        }
        return reviews;
    }

    public boolean addReview(Reviews review) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(ADD_REVIEW)) {
            ps.setInt(1, review.getPatient().getUser_id());
            // Sử dụng setInt với Types.NULL để xử lý ID null
            if (review.getService() != null) {
                ps.setInt(2, review.getService().getService_id());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            if (review.getAppointment() != null) {
                ps.setInt(3, review.getAppointment().getAppointment_id());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getComment());
            ps.setTimestamp(6, Timestamp.valueOf(review.getCreated_at()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm review", e);
        }
    }

    public boolean updateReview(Reviews review) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_REVIEW)) {
            // Xử lý serviceId null/non-null (Chỉ kiểm tra đối tượng service)
            if (review.getService() != null) {
                ps.setInt(1, review.getService().getService_id());
            } else {
                ps.setNull(1, Types.INTEGER);
            }

            // Xử lý appointmentId null/non-null (Chỉ kiểm tra đối tượng appointment)
            if (review.getAppointment() != null) {
                ps.setInt(2, review.getAppointment().getAppointment_id());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.setInt(5, review.getReview_id());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật review id=" + review.getReview_id(), e);
        }
    }

    public boolean deleteReview(int review_id) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_REVIEW)) {
            ps.setInt(1, review_id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa review id=" + review_id, e);
        }
    }

    // ================= HELPER =================
    private Reviews mapResultSetToReview(ResultSet rs) throws SQLException {
        Reviews review = new Reviews();
        review.setReview_id(rs.getInt("review_id"));

        User patient = new User();
        patient.setUser_id(rs.getInt("patient_id"));
        review.setPatient(patient);

        int serviceId = rs.getInt("service_id");
        if (!rs.wasNull()) {
            Action_Service service = new Action_Service();
            service.setService_id(serviceId);
            review.setService(service);
        }

        int appointmentId = rs.getInt("appointment_id");
        if (!rs.wasNull()) {
            Appointments appointment = new Appointments();
            appointment.setAppointment_id(appointmentId);
            review.setAppointment(appointment);
        }

        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));

        Timestamp datetime = rs.getTimestamp("created_at");
        if (datetime != null) {
            review.setCreated_at(datetime.toLocalDateTime());
        }

        return review;
    }

    private Appointments mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointments appointment = new Appointments();
        appointment.setAppointment_id(rs.getInt("appointment_id"));
        appointment.setAppointment_code(rs.getString("appointment_code"));

        User patient = new User();
        patient.setUser_id(rs.getInt("patient_id"));
        appointment.setPatient_id(patient);

        Action_Service service = new Action_Service();
        service.setService_id(rs.getInt("service_id"));
        // Service ID trong bảng Appointments là NOT NULL nên không cần kiểm tra rs.wasNull()
        appointment.setService_id(service);

        Date date = rs.getDate("appointment_date");
        Time time = rs.getTime("appointment_time");
        Timestamp createdAtTimestamp = rs.getTimestamp("created_at");

        if (date != null) {
            appointment.setAppointment_date(date.toLocalDate());
        }
        if (time != null) {
            appointment.setAppointment_time(time.toLocalTime());
        }
        if (createdAtTimestamp != null) {
            appointment.setCreated_at(createdAtTimestamp.toLocalDateTime());
        }

        appointment.setStatus(rs.getString("status"));
        appointment.setNote(rs.getString("note"));

        return appointment;
    }

    private Action_Service mapResultSetToSimpleService(ResultSet rs) throws SQLException {
        Action_Service service = new Action_Service();
        service.setService_id(rs.getInt("service_id"));
        service.setService_name(rs.getString("service_name"));
        return service;
    }

    // ================= QUYỀN RIÊNG =================

    public List<Action_Service> getServicesByPatientId(Integer patientId) {
        List<Action_Service> services = new ArrayList<>();

        if (patientId == null) {
            return services;
        }

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(FIND_SERVICES_BY_PATIENT)) {

            pstmt.setInt(1, patientId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    services.add(mapResultSetToSimpleService(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn dịch vụ của bệnh nhân ID " + patientId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return services;
    }

    public List<Appointments> getAppointmentsByPatientId(Integer patientId) {
        List<Appointments> appointments = new ArrayList<>();

        if (patientId == null) {
            return appointments;
        }

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(FIND_APPOINTMENTS_BY_PATIENT)) {

            pstmt.setInt(1, patientId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn lịch hẹn của bệnh nhân ID " + patientId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

}
