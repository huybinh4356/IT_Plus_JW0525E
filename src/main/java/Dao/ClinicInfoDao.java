package Dao;

import model.ClinicInfo;
import Dao.MySql_JDBC.Connection_DreamTooth; // Giả định package này chứa kết nối
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

public class ClinicInfoDao {
    private Connection conn;
    private static ClinicInfoDao clinicInfoDao;

    // Query constants
    private final String FIND_ALL = "SELECT * FROM ClinicInfo";
    private final String FIND_BY_ID = "SELECT * FROM ClinicInfo WHERE clinic_id=?"; // BỔ SUNG
    private final String ADD_CLINIC = "INSERT INTO ClinicInfo(name, address, hostline, email, working_hours, description, logo) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private final String UPDATE_CLINIC = "UPDATE ClinicInfo SET name=?, address=?, hostline=?, email=?, working_hours=?, description=?, logo=? WHERE clinic_id=?";
    private final String DELETE_CLINIC = "DELETE FROM ClinicInfo WHERE clinic_id=?";

    public ClinicInfoDao() {
        // Giả định Connection_DreamTooth.getConnection() hoạt động
        this.conn = Connection_DreamTooth.getConnection();
    }

    public static ClinicInfoDao getInstance() {
        if (clinicInfoDao == null) {
            clinicInfoDao = new ClinicInfoDao();
        }
        return clinicInfoDao;
    }

    // Lấy tất cả phòng khám
    public List<ClinicInfo> findAll() {
        List<ClinicInfo> clinicInfos = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ClinicInfo clinicInfo = new ClinicInfo();
                clinicInfo.setClinic_id(rs.getInt("clinic_id"));
                clinicInfo.setName(rs.getString("name"));
                clinicInfo.setAddress(rs.getString("address"));
                clinicInfo.setHostline(rs.getString("hostline"));
                clinicInfo.setEmail(rs.getString("email"));
                clinicInfo.setWorking_hours(rs.getString("working_hours"));
                clinicInfo.setDescription(rs.getString("description"));
                clinicInfo.setLogo(rs.getString("logo"));
                clinicInfos.add(clinicInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clinicInfos;
    }

    // Tìm phòng khám theo ID (BỔ SUNG)
    public ClinicInfo findById(int clinic_id) {
        ClinicInfo clinicInfo = null;
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {
            ps.setInt(1, clinic_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    clinicInfo = new ClinicInfo();
                    clinicInfo.setClinic_id(rs.getInt("clinic_id"));
                    clinicInfo.setName(rs.getString("name"));
                    clinicInfo.setAddress(rs.getString("address"));
                    clinicInfo.setHostline(rs.getString("hostline"));
                    clinicInfo.setEmail(rs.getString("email"));
                    clinicInfo.setWorking_hours(rs.getString("working_hours"));
                    clinicInfo.setDescription(rs.getString("description"));
                    clinicInfo.setLogo(rs.getString("logo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clinicInfo;
    }

    // Thêm phòng khám
    public ClinicInfo addClinicInfo(ClinicInfo clinicInfo) {
        try (PreparedStatement ps = conn.prepareStatement(ADD_CLINIC, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, clinicInfo.getName());
            ps.setString(2, clinicInfo.getAddress());
            ps.setString(3, clinicInfo.getHostline());
            ps.setString(4, clinicInfo.getEmail());
            ps.setString(5, clinicInfo.getWorking_hours());
            ps.setString(6, clinicInfo.getDescription());
            ps.setString(7, clinicInfo.getLogo());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        clinicInfo.setClinic_id(generatedKeys.getInt(1));
                    }
                }
                return clinicInfo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật phòng khám
    public boolean updateClinicInfo(ClinicInfo clinicInfo) {
        try (PreparedStatement ps = conn.prepareStatement(UPDATE_CLINIC)) {
            ps.setString(1, clinicInfo.getName());
            ps.setString(2, clinicInfo.getAddress());
            ps.setString(3, clinicInfo.getHostline());
            ps.setString(4, clinicInfo.getEmail());
            ps.setString(5, clinicInfo.getWorking_hours());
            ps.setString(6, clinicInfo.getDescription());
            ps.setString(7, clinicInfo.getLogo());
            ps.setInt(8, clinicInfo.getClinic_id());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa phòng khám
    public boolean deleteClinicInfo(int clinic_id) {
        try (PreparedStatement ps = conn.prepareStatement(DELETE_CLINIC)) {
            ps.setInt(1, clinic_id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}