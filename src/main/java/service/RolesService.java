//package service;
//
//import Dao.RolesDao;
//import model.Roles;
//
//import java.util.List;
//
//public class RolesService {
//    private final RolesDao rolesDao;
//    private static RolesService instance;
//
//    private RolesService() {
//        this.rolesDao = RolesDao.getInstance();
//    }
//
//    public static RolesService getInstance() {
//        if (instance == null) {
//            instance = new RolesService();
//        }
//        return instance;
//    }
//
//    public Roles addRole(Roles role) {
//        return rolesDao.addRole(role); // trả về role kèm id nếu thêm thành công
//    }
//
//    public List<Roles> findAll() {
//        return rolesDao.findAll();
//    }
//
//    public Roles findById(int id) {
//        return rolesDao.findById(id);
//    }
//
//    public boolean updateRole(Roles role) {
//        return rolesDao.updateRole(role);
//    }
//
//    public boolean deleteRole(int id) {
//        return rolesDao.deleteRole(id);
//    }
//}
