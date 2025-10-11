package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Specialties;
import Dao.MySql_JDBC.Connection_DreamTooth;

public class SpecialtiesDao {
    private final Connection conn;
    private static SpecialtiesDao specialtiesDao;

    private final String FIND_ALL = "SELECT * FROM Specialties";
    private final String FIND_BY_ID = "SELECT * FROM Specialties WHERE specialty_id=?";
    private final String FIND_BY_NAME = "SELECT * FROM Specialties WHERE name=?";
    private final String FIND_BY_DESCRIPTION = "SELECT * FROM Specialties WHERE description=?";

    // CRUD query
    private final String ADD_SPECIALTY = "INSERT INTO Specialties(name, description) VALUES (?, ?)";
    private final String UPDATE_SPECIALTY = "UPDATE Specialties SET name=?, description=? WHERE specialty_id=?";
    private final String DELETE_SPECIALTY = "DELETE FROM Specialties WHERE specialty_id=?";

    private SpecialtiesDao() {
        this.conn = Connection_DreamTooth.getConnection();
    }

    public static SpecialtiesDao getSpecialtiesDao() {
        if (specialtiesDao == null) {
            specialtiesDao = new SpecialtiesDao();
        }
        return specialtiesDao;
    }

    // ---------------- FIND ----------------
    public List<Specialties> findAll() {
        List<Specialties> specialties = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Specialties special = new Specialties();
                special.setSpecialtyId(rs.getInt("specialty_id"));
                special.setName(rs.getString("name"));
                special.setDescription(rs.getString("description"));
                specialties.add(special);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specialties;
    }

    public Specialties findById(int specialties_id) {
        Specialties special = null;
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_ID)) {
            ps.setInt(1, specialties_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    special = new Specialties();
                    special.setSpecialtyId(rs.getInt("specialty_id"));
                    special.setName(rs.getString("name"));
                    special.setDescription(rs.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return special;
    }

    public List<Specialties> findByName(String name) {
        List<Specialties> specialtiesList = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_NAME)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Specialties special = new Specialties();
                    special.setSpecialtyId(rs.getInt("specialty_id"));
                    special.setName(rs.getString("name"));
                    special.setDescription(rs.getString("description"));
                    specialtiesList.add(special);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specialtiesList;
    }

    public List<Specialties> findByDescription(String description) {
        List<Specialties> specialtiesList = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(FIND_BY_DESCRIPTION)) {
            ps.setString(1, description);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Specialties special = new Specialties();
                    special.setSpecialtyId(rs.getInt("specialty_id"));
                    special.setName(rs.getString("name"));
                    special.setDescription(rs.getString("description"));
                    specialtiesList.add(special);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specialtiesList;
    }

    // ---------------- ADD, UPDATE, DELETE ----------------
    public boolean addSpecialty(Specialties special) {
        try (PreparedStatement ps = conn.prepareStatement(ADD_SPECIALTY)) {
            ps.setString(1, special.getName());
            ps.setString(2, special.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSpecialty(Specialties special) {
        try (PreparedStatement ps = conn.prepareStatement(UPDATE_SPECIALTY)) {
            ps.setString(1, special.getName());
            ps.setString(2, special.getDescription());
            ps.setInt(3, special.getSpecialtyId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSpecialty(int specialties_id) {
        try (PreparedStatement ps = conn.prepareStatement(DELETE_SPECIALTY)) {
            ps.setInt(1, specialties_id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
