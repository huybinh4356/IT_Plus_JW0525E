package service;

import Dao.ServiceDao;
import model.Action_Service;
import java.util.List;

public class ServiceService {
    private final ServiceDao serviceDao;
    private static ServiceService instance;

    private ServiceService() {
        // dùng singleton của DAO
        this.serviceDao = ServiceDao.getInstance();
    }

    // Singleton pattern
    public static ServiceService getInstance() {
        if (instance == null) {
            instance = new ServiceService();
        }
        return instance;
    }

    // -------------------- CRUD + Validate --------------------

    public boolean addService(Action_Service service) {
        if (service == null) throw new IllegalArgumentException("Service không được null");
        if (service.getService_name() == null || service.getService_name().isEmpty())
            throw new IllegalArgumentException("Tên dịch vụ không hợp lệ");
        if (service.getPrice() < 0)
            throw new IllegalArgumentException("Giá dịch vụ không được âm");

        return serviceDao.addService(service);
    }

    public List<Action_Service> getAllServices() {
        return serviceDao.findAll();
    }

    public Action_Service getServiceById(int id) {
        if (id <= 0) throw new IllegalArgumentException("ID dịch vụ không hợp lệ");
        return serviceDao.findById(id);
    }

    public Action_Service getServiceByName(String name) {
        if (name == null || name.isEmpty())
            throw new IllegalArgumentException("Tên dịch vụ không hợp lệ");
        return serviceDao.findByName(name);
    }

    public List<Action_Service> getServicesByCategory(String category) {
        if (category == null || category.isEmpty())
            throw new IllegalArgumentException("Category không hợp lệ");
        return serviceDao.findByCategory(category);
    }

    public List<Action_Service> getServicesByTechnology(String technology) {
        if (technology == null || technology.isEmpty())
            throw new IllegalArgumentException("Technology không hợp lệ");
        return serviceDao.findByTechnology(technology);
    }

    public List<Action_Service> getServicesByPrice(double price) {
        if (price < 0) throw new IllegalArgumentException("Giá tìm kiếm không hợp lệ");
        return serviceDao.findByPrice(price);
    }

    public boolean updateService(Action_Service service) {
        if (service == null || service.getService_id() <= 0)
            throw new IllegalArgumentException("Service không hợp lệ");
        return serviceDao.updateService(service);
    }

    public boolean deleteService(int id) {
        if (id <= 0) throw new IllegalArgumentException("ID dịch vụ không hợp lệ");
        return serviceDao.deleteService(id);
    }
}
