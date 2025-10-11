package service;

import Dao.SpecialtiesDao;
import model.Specialties;
import java.util.List;

public class SpecialtiesService {
    private final SpecialtiesDao specialtiesDao;
    private static SpecialtiesService spec;

    // Singleton cho Service
    private SpecialtiesService() {
        this.specialtiesDao = SpecialtiesDao.getSpecialtiesDao();
    }

    public static SpecialtiesService getInstance() {
        if (spec == null) {
            spec = new SpecialtiesService();
        }
        return spec;
    }

    public List<Specialties> findAll() {
        return specialtiesDao.findAll();
    }

    public Specialties findById(int id) {
        return specialtiesDao.findById(id);
    }

    public List<Specialties> findByName(String name) {
        return specialtiesDao.findByName(name);
    }

    public List<Specialties> findByDescription(String description) {
        return specialtiesDao.findByDescription(description);
    }

    public boolean addSpecialty(Specialties specialties) {
        return specialtiesDao.addSpecialty(specialties);
    }

    public boolean updateSpecialty(Specialties specialties) {
        return specialtiesDao.updateSpecialty(specialties);
    }

    public boolean deleteSpecialty(int id) {
        return specialtiesDao.deleteSpecialty(id);
    }
}
