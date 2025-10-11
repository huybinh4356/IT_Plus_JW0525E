package Dao;

import Dao.MySql_JDBC.Connection_DreamTooth;
import model.Action_Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDao {
    private Connection conn;
    private static ServiceDao serviceDao;

    private final String FIND_ALL = "SELECT * FROM Services";
    private final String FIND_BY_ID = "SELECT * FROM Services WHERE service_id = ?";
    private final String FIND_BY_NAME = "SELECT * FROM Services WHERE service_name = ?";
    private final String FIND_BY_CATEGORY = "SELECT * FROM Services WHERE category = ?";
    private final String FIND_BY_TECHNOLOGY = "SELECT * FROM Services WHERE technology = ?";
    private final String FIND_BY_PRICE = "SELECT * FROM Services WHERE price = ?";
    private final String ADD_SERVICE =
            "INSERT INTO Services(service_name, category, description, target_customer, process, technology, duration, warranty_policy, price, is_active) " +
                    "VALUES(?,?,?,?,?,?,?,?,?,?)";
    private final String UPDATE_SERVICE =
            "UPDATE Services SET service_name=?, category=?, description=?, target_customer=?, process=?, technology=?, duration=?, warranty_policy=?, price=?, is_active=? " +
                    "WHERE service_id=?";
    private final String DELETE_SERVICE = "DELETE FROM Services WHERE service_id=?";

    public ServiceDao() {
        conn = Connection_DreamTooth.getConnection();
    }

    public static ServiceDao getInstance() {
        if (serviceDao == null) {
            serviceDao = new ServiceDao();
        }
        return serviceDao;
    }

    // -------------------- MAP ResultSet → Object --------------------
    private Action_Service mapResultSetToService(ResultSet rs) {
        Action_Service service = new Action_Service();
        try {
            service.setService_id(rs.getInt("service_id"));
            service.setService_name(rs.getString("service_name"));
            service.setCategory(rs.getString("category"));
            service.setDescription(rs.getString("description"));
            service.setTarget_customer(rs.getString("target_customer"));
            service.setProcess(rs.getString("process"));
            service.setTechnology(rs.getString("technology"));
            service.setDuration(rs.getString("duration"));
            service.setWarranty_policy(rs.getString("warranty_policy"));
            service.setPrice(rs.getDouble("price"));
            service.setIs_active(rs.getBoolean("is_active"));
            Timestamp ts = rs.getTimestamp("created_at");
            if (ts != null) {
                service.setCreated_at(ts.toLocalDateTime());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return service;
    }

    // -------------------- CRUD METHODS --------------------

    public List<Action_Service> findAll() {
        List<Action_Service> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Action_Service findById(int id) {
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToService(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Action_Service findByName(String name) {
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_NAME)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToService(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Action_Service> findByCategory(String category) {
        List<Action_Service> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_CATEGORY)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Action_Service> findByTechnology(String technology) {
        List<Action_Service> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_TECHNOLOGY)) {
            ps.setString(1, technology);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Action_Service> findByPrice(double price) {
        List<Action_Service> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_PRICE)) {
            ps.setDouble(1, price);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addService(Action_Service service) {
        try (PreparedStatement ps = conn.prepareStatement(ADD_SERVICE)) {
            ps.setString(1, service.getService_name());
            ps.setString(2, service.getCategory());
            ps.setString(3, service.getDescription());
            ps.setString(4, service.getTarget_customer());
            ps.setString(5, service.getProcess());
            ps.setString(6, service.getTechnology());
            ps.setString(7, service.getDuration());
            ps.setString(8, service.getWarranty_policy());
            ps.setDouble(9, service.getPrice());
            ps.setBoolean(10, service.isIs_active());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateService(Action_Service service) {
        try (PreparedStatement ps = conn.prepareStatement(UPDATE_SERVICE)) {
            ps.setString(1, service.getService_name());
            ps.setString(2, service.getCategory());
            ps.setString(3, service.getDescription());
            ps.setString(4, service.getTarget_customer());
            ps.setString(5, service.getProcess());
            ps.setString(6, service.getTechnology());
            ps.setString(7, service.getDuration());
            ps.setString(8, service.getWarranty_policy());
            ps.setDouble(9, service.getPrice());
            ps.setBoolean(10, service.isIs_active());
            ps.setInt(11, service.getService_id());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteService(int id) {
        try (PreparedStatement ps = conn.prepareStatement(DELETE_SERVICE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
