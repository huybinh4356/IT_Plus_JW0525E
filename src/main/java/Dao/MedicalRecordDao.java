package Dao;

import model.MedicalRecords;
import model.User;
import model.Appointments;
import Dao.MySql_JDBC.Connection_DreamTooth;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDao {

    private static MedicalRecordDao instance;

    private MedicalRecordDao() {
    }

    public static MedicalRecordDao getInstance() {
        if (instance == null) {
            instance = new MedicalRecordDao();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException {
        return Connection_DreamTooth.getConnection();
    }


    // Thao tác CREATE
    public boolean addMedicalRecord(MedicalRecords record) {
        String sql = "INSERT INTO MedicalRecords (patient_id, appointment_id, diagnosis, treatment, notes, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, record.getPatient_id().getUser_id());
            // Sử dụng logic ternary để xử lý trường hợp appointment_id là null
            // LƯU Ý: Nếu cột DB cho phép NULL, bạn nên dùng ps.setNull(2, Types.INTEGER) thay vì 0
            ps.setObject(2, record.getAppointment_id() != null ? record.getAppointment_id().getAppointment_id() : null, Types.INTEGER);
            ps.setString(3, record.getDiagnosis());
            ps.setString(4, record.getTreatment());
            ps.setString(5, record.getNotes());
            ps.setTimestamp(6, Timestamp.valueOf(record.getCreated_at()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thao tác READ (All)
    public List<MedicalRecords> findAll() {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecords ORDER BY created_at DESC";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSetToMedicalRecord(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ⭐️ THÊM MỚI: Thao tác READ (By Record ID)
    public MedicalRecords findById(int recordId) {
        String sql = "SELECT * FROM MedicalRecords WHERE record_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recordId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMedicalRecord(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thao tác READ (By Patient ID)
    public List<MedicalRecords> findByPatientId(int patientId) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecords WHERE patient_id = ? ORDER BY created_at DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToMedicalRecord(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thao tác READ (By Date)
    public List<MedicalRecords> findByCreatedAt(LocalDateTime createdAt) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecords WHERE DATE(created_at) = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(createdAt.toLocalDate()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToMedicalRecord(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thao tác UPDATE
    public boolean updateMedicalRecord(MedicalRecords record) {
        String sql = "UPDATE MedicalRecords SET patient_id=?, appointment_id=?, diagnosis=?, treatment=?, notes=? WHERE record_id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, record.getPatient_id().getUser_id());
            ps.setObject(2, record.getAppointment_id() != null ? record.getAppointment_id().getAppointment_id() : null, Types.INTEGER);
            ps.setString(3, record.getDiagnosis());
            ps.setString(4, record.getTreatment());
            ps.setString(5, record.getNotes());
            ps.setInt(6, record.getRecord_id());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thao tác DELETE
    public boolean deleteMedicalRecord(int recordId) {
        String sql = "DELETE FROM MedicalRecords WHERE record_id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recordId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method để ánh xạ ResultSet sang đối tượng MedicalRecords
    // CHỈ GÁN ID CHO KHÓA NGOẠI TẠI ĐÂY, SẼ NẠP ĐẦY ĐỦ Ở SERVICE
    private MedicalRecords mapResultSetToMedicalRecord(ResultSet rs) throws SQLException {
        MedicalRecords record = new MedicalRecords();
        record.setRecord_id(rs.getInt("record_id"));

        // Gán ID Bệnh nhân
        User patient = new User();
        patient.setUser_id(rs.getInt("patient_id"));
        record.setPatient_id(patient);

        // Gán ID Lịch hẹn (Xử lý trường hợp NULL)
        int appointmentId = rs.getInt("appointment_id");
        if (!rs.wasNull()) { // Kiểm tra nếu giá trị không phải là NULL trong DB
            Appointments app = new Appointments();
            app.setAppointment_id(appointmentId);
            record.setAppointment_id(app);
        } else {
            record.setAppointment_id(null);
        }

        // Cần thêm logic lấy Doctor ID (nếu có)
        // int doctorId = rs.getInt("doctor_id");
        // if (!rs.wasNull()) { ... }

        record.setDiagnosis(rs.getString("diagnosis"));
        record.setTreatment(rs.getString("treatment"));
        record.setNotes(rs.getString("notes"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            record.setCreated_at(ts.toLocalDateTime());
        }
        return record;
    }
}