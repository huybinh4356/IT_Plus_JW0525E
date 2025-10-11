//package Dao;
//
//import Dao.MySql_JDBC.Connection_DreamTooth;
//import model.Roles;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class RolesDao {
//    private final Connection conn;
//    private static RolesDao rolesDao;
//
//    // SQL queries
//    private final String FIND_ALL = "SELECT * FROM Roles";
//    private final String FIND_BY_ID = "SELECT * FROM Roles WHERE role_id = ?";
//    private final String INSERT_ROLE = "INSERT INTO Roles(name) VALUES (?)";
//    private final String UPDATE_ROLE = "UPDATE Roles SET name=? WHERE role_id=?";
//    private final String DELETE_ROLE = "DELETE FROM Roles WHERE role_id=?";
//
//    public RolesDao() {
//        this.conn = Connection_DreamTooth.getConnection();
//    }
//
//    public static RolesDao getInstance() {
//        if (rolesDao == null) {
//            rolesDao = new RolesDao();
//        }
//        return rolesDao;
//    }
//
//    // CREATE
//    public Roles addRole(Roles role) {
//        try (PreparedStatement ps = conn.prepareStatement(INSERT_ROLE, Statement.RETURN_GENERATED_KEYS)) {
//            ps.setString(1, role.getName());
//            int affectedRows = ps.executeUpdate();
//
//            if (affectedRows > 0) {
//                try (ResultSet rs = ps.getGeneratedKeys()) {
//                    if (rs.next()) {
//                        role.setRole_id(rs.getInt(1));
//                    }
//                }
//                return role;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    // READ ALL
//    public List<Roles> findAll() {
//        List<Roles> roles = new ArrayList<>();
//        try (PreparedStatement ps = conn.prepareStatement(FIND_ALL);
//             ResultSet rs = ps.executeQuery()) {
//
//            while (rs.next()) {
//                Roles role = new Roles();
//                role.setRole_id(rs.getInt("role_id"));
//                role.setName(rs.getString("name"));
//                roles.add(role);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return roles;
//    }
//
//    // READ BY ID
//    public Roles findById(int id) {
//        Roles role = null;
//        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {
//            ps.setInt(1, id);
//
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    role = new Roles();
//                    role.setRole_id(rs.getInt("role_id"));
//                    role.setName(rs.getString("name"));
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return role;
//    }
//
//    // UPDATE
//    public boolean updateRole(Roles role) {
//        try (PreparedStatement ps = conn.prepareStatement(UPDATE_ROLE)) {
//            ps.setString(1, role.getName());
//            ps.setInt(2, role.getRole_id());
//            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//
//    // DELETE
//    public boolean deleteRole(int id) {
//        try (PreparedStatement ps = conn.prepareStatement(DELETE_ROLE)) {
//            ps.setInt(1, id);
//            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//}
