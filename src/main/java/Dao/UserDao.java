package Dao;

import model.Specialties;
import model.User;
import Dao.MySql_JDBC.Connection_DreamTooth;

import java.sql.*;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    private static UserDao userDao;

    private UserDao() {
    }

    public static UserDao getInstance() {
        if (userDao == null) {
            userDao = new UserDao();
        }
        return userDao;
    }

    private Connection getConnection() throws SQLException {
        return Connection_DreamTooth.getConnection();
    }

    // =============================================================
    // THÊM (CREATE)
    // =============================================================
    public boolean addUser(User user) {
        String sql = "INSERT INTO users(username, password_hash, full_name, dob, gender, cccd, phone, email, address, role_id, specialty_id, degree, position, is_active, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword_hash());
            ps.setString(3, user.getFull_name());
            ps.setDate(4, user.getDob() != null ? Date.valueOf(user.getDob()) : null);
            ps.setString(5, user.getGender());
            ps.setString(6, user.getCccd());
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getEmail());
            ps.setString(9, user.getAddress());
            ps.setInt(10, user.getRole_id());

            if (user.getSpecialty() != null && user.getSpecialty().getSpecialtyId() > 0) {
                ps.setInt(11, user.getSpecialty().getSpecialtyId());
            } else {
                ps.setNull(11, Types.INTEGER);
            }

            ps.setString(12, user.getDegree());
            ps.setString(13, user.getPosition());
            ps.setBoolean(14, user.isIs_active());

            if (user.getCreated_at() != null) {
                ps.setTimestamp(15, Timestamp.valueOf(user.getCreated_at()));
            } else {
                ps.setTimestamp(15, new Timestamp(System.currentTimeMillis()));
            }

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // =============================================================
    // LẤY TẤT CẢ & THEO ROLE (READ ALL)
    // =============================================================
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "ORDER BY u.user_id";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> findByRoleId(int roleId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.role_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roleId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =============================================================
    // LẤY THEO ID/USERNAME (READ SINGLE)
    // =============================================================
    public User findById(int user_id) {
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);

            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findByUsername(String username) {
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.username = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findByCccd(String cccd) {
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.cccd = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cccd);

            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // =============================================================
    // TÌM KIẾM THEO THUỘC TÍNH (SEARCH)
    // =============================================================
    public List<User> findByName(String name) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.full_name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> findByGender(String gender) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.gender = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, gender);

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> findByEmail(String email) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.email LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + email + "%");

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> findByPhone(String phone) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.phone = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> findByAddress(String address) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, s.name as specialty_name, s.description as specialty_description " +
                "FROM users u LEFT JOIN specialties s ON u.specialty_id = s.specialty_id " +
                "WHERE u.address LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + address + "%");

            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =============================================================
    // CẬP NHẬT & XÓA (UPDATE & DELETE)
    // =============================================================
    public boolean updateUser(User user) {
        String baseSql = "UPDATE users SET username=?, full_name=?, dob=?, gender=?, cccd=?, phone=?, email=?, address=?, role_id=?, specialty_id=?, degree=?, position=?, is_active=? ";
        String passwordPart = "";
        int nextIndex = 1;

        boolean updatePassword = user.getPassword_hash() != null && !user.getPassword_hash().isEmpty();

        if (updatePassword) {
            passwordPart = ", password_hash=? ";
        }

        String finalSql = baseSql + passwordPart + " WHERE user_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(finalSql)) {

            ps.setString(nextIndex++, user.getUsername());
            ps.setString(nextIndex++, user.getFull_name());
            ps.setDate(nextIndex++, user.getDob() != null ? Date.valueOf(user.getDob()) : null);
            ps.setString(nextIndex++, user.getGender());
            ps.setString(nextIndex++, user.getCccd());
            ps.setString(nextIndex++, user.getPhone());
            ps.setString(nextIndex++, user.getEmail());
            ps.setString(nextIndex++, user.getAddress());
            ps.setInt(nextIndex++, user.getRole_id());

            if (updatePassword) {
                ps.setString(nextIndex++, user.getPassword_hash());
            }

            if (user.getSpecialty() != null && user.getSpecialty().getSpecialtyId() > 0) {
                ps.setInt(nextIndex++, user.getSpecialty().getSpecialtyId());
            } else {
                ps.setNull(nextIndex++, Types.INTEGER);
            }

            ps.setString(nextIndex++, user.getDegree());
            ps.setString(nextIndex++, user.getPosition());
            ps.setBoolean(nextIndex++, user.isIs_active());

            ps.setInt(nextIndex, user.getUser_id());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int user_id) {
        String sql = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);

            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapResultSetToUser(ResultSet rs) {
        try {
            User user = new User();
            user.setUser_id(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            user.setPassword_hash(rs.getString("password_hash"));
            user.setFull_name(rs.getString("full_name"));

            Date dob = rs.getDate("dob");
            if (dob != null) {
                user.setDob(dob.toLocalDate());
                user.setFormattedDob(dob.toLocalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            } else {
                user.setFormattedDob("—");
            }

            user.setGender(rs.getString("gender"));
            user.setCccd(rs.getString("cccd"));
            user.setPhone(rs.getString("phone"));
            user.setEmail(rs.getString("email"));
            user.setAddress(rs.getString("address"));
            user.setRole_id(rs.getInt("role_id"));

            int spId = rs.getInt("specialty_id");
            if (!rs.wasNull()) {
                Specialties sp = new Specialties();
                sp.setSpecialtyId(spId);

                try {
                    sp.setName(rs.getString("specialty_name"));
                    sp.setDescription(rs.getString("specialty_description"));
                } catch (SQLException ignored) {}

                user.setSpecialty(sp);
            }

            user.setDegree(rs.getString("degree"));
            user.setPosition(rs.getString("position"));
            user.setIs_active(rs.getBoolean("is_active"));

            Timestamp createdAt = rs.getTimestamp("created_at");
            if (createdAt != null) {
                user.setCreated_at(createdAt.toLocalDateTime());
                user.setFormattedCreatedAt(createdAt.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")));
            } else {
                user.setFormattedCreatedAt("—");
            }

            return user;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}