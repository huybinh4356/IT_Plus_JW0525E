package Dao;

import Dao.MySql_JDBC.Connection_DreamTooth;
import model.GuestRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuestRequestDao {
    private final Connection conn;
    private static GuestRequestDao guestRequestDao;

    private GuestRequestDao(){
        this.conn = Connection_DreamTooth.getConnection();
    }
    public static GuestRequestDao getQuestRequestDao(){
        if(guestRequestDao == null){
            guestRequestDao = new GuestRequestDao();
        }
        return guestRequestDao;
    }
    public boolean addGuestRequest(GuestRequest request) {
        String sql = "INSERT INTO GuestRequests (full_name, phone, email, cccd, address, message) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, request.getFullName());
            ps.setString(2, request.getPhone());
            ps.setString(3, request.getEmail());
            ps.setString(4, request.getCccd());
            ps.setString(5, request.getAddress());
            ps.setString(6, request.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // log lỗi
        }
        return false;
    }
    public GuestRequest findById(int requestId) {
        String sql = "SELECT * FROM GuestRequests WHERE request_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<GuestRequest> findAll() {
        String sql = "SELECT * FROM GuestRequests ORDER BY created_at DESC";
        List<GuestRequest> list = new ArrayList<>();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GuestRequest> findByFullName(String fullName) {
        String sql = "SELECT * FROM GuestRequests WHERE full_name LIKE ?";
        List<GuestRequest> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + fullName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public GuestRequest findByCCCD(String cccd) {
        String sql = "SELECT * FROM GuestRequests WHERE cccd = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cccd);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public GuestRequest findByPhone(String phone) {
        String sql = "SELECT * FROM GuestRequests WHERE phone = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateGuestRequest(GuestRequest request) {
        String sql = "UPDATE GuestRequests SET full_name=?, phone=?, email=?, cccd=?, address=?, message=? " +
                "WHERE request_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, request.getFullName());
            ps.setString(2, request.getPhone());
            ps.setString(3, request.getEmail());
            ps.setString(4, request.getCccd());
            ps.setString(5, request.getAddress());
            ps.setString(6, request.getMessage());
            ps.setInt(7, request.getRequestId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteGuestRequest(int requestId) {
        String sql = "DELETE FROM GuestRequests WHERE request_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ====== Map dữ liệu ResultSet → Model ======
    private GuestRequest mapResultSet(ResultSet rs) throws SQLException {
        return new GuestRequest(
                rs.getInt("request_id"),
                rs.getString("full_name"),
                rs.getString("phone"),
                rs.getString("email"),
                rs.getString("cccd"),
                rs.getString("address"),
                rs.getString("message"),
                rs.getTimestamp("created_at")
        );
    }
}
