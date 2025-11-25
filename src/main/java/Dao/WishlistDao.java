package Dao;

import Dao.MySql_JDBC.Connection_DreamTooth;
import model.Action_Service;
import model.User;
import model.Wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class WishlistDao extends Connection_DreamTooth {

    // 1. Lấy danh sách Wishlist của một Bệnh nhân cụ thể
    public List<Wishlist> getWishlistByUserId(int userId) {
        List<Wishlist> list = new ArrayList<>();
        // Đã xóa s.image để tránh lỗi
        String sql = "SELECT w.wishlist_id, w.notes, w.add_at, " +
                "s.service_id, s.service_name, s.price, s.technology, s.is_active " +
                "FROM Wishlist w " +
                "JOIN Services s ON w.service_id = s.service_id " +
                "WHERE w.patient_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Wishlist w = mapResultSetToWishlist(rs, userId);
                    list.add(w);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm một dịch vụ vào Wishlist
    public boolean addToWishlist(int userId, int serviceId, String notes) {
        if (checkExist(userId, serviceId)) {
            return false;
        }
        String sql = "INSERT INTO Wishlist (patient_id, service_id, notes, add_at) VALUES (?, ?, ?, NOW())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setString(3, notes);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Xóa một mục khỏi Wishlist
    public boolean deleteWishlistItem(int wishlistId) {
        String sql = "DELETE FROM Wishlist WHERE wishlist_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, wishlistId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. Kiểm tra tồn tại
    public boolean checkExist(int userId, int serviceId) {
        String sql = "SELECT 1 FROM Wishlist WHERE patient_id = ? AND service_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. (MỚI) Cập nhật ghi chú
    public boolean updateNote(int wishlistId, String newNote) {
        String sql = "UPDATE Wishlist SET notes = ? WHERE wishlist_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newNote);
            ps.setInt(2, wishlistId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6. (MỚI) Tìm kiếm trong Wishlist
    public List<Wishlist> searchWishlist(int userId, String keyword) {
        List<Wishlist> list = new ArrayList<>();
        String sql = "SELECT w.wishlist_id, w.notes, w.add_at, " +
                "s.service_id, s.service_name, s.price, s.technology, s.is_active " +
                "FROM Wishlist w " +
                "JOIN Services s ON w.service_id = s.service_id " +
                "WHERE w.patient_id = ? AND s.service_name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Wishlist w = mapResultSetToWishlist(rs, userId);
                    list.add(w);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm phụ trợ để map dữ liệu (đỡ viết lại nhiều lần)
    private Wishlist mapResultSetToWishlist(ResultSet rs, int userId) throws java.sql.SQLException {
        Wishlist w = new Wishlist();
        w.setWishlist_id(rs.getInt("wishlist_id"));
        w.setNotes(rs.getString("notes"));

        Timestamp ts = rs.getTimestamp("add_at");
        if (ts != null) {
            w.setAdd_at(ts.toLocalDateTime());
        }

        User u = new User();
        u.setUser_id(userId);
        w.setPatient_id(u);

        Action_Service s = new Action_Service();
        s.setService_id(rs.getInt("service_id"));
        s.setService_name(rs.getString("service_name"));
        s.setPrice(rs.getInt("price"));
        s.setTechnology(rs.getString("technology"));
        s.setIs_active(rs.getBoolean("is_active"));

        w.setService_id(s);
        return w;
    }
}