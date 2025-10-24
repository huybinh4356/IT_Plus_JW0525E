package service;

import Dao.UserDao;
import model.User;

import java.util.Collections;
import java.util.List;

public class UserService {
    private final UserDao userDao;
    private static UserService instance;

    private UserService() {
        this.userDao = UserDao.getInstance();
    }

    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    // ===============================================
    // PHƯƠNG THỨC XÁC THỰC & CRUD
    // ===============================================

    public User authenticate(String username, String rawPassword) {
        if (username == null || rawPassword == null || username.isEmpty() || rawPassword.isEmpty()) {
            return null;
        }

        User user = userDao.findByUsername(username);

        if (user == null || user.getPassword_hash() == null || user.getPassword_hash().isEmpty()) {
            return null;
        }

        // Lưu ý: Cần sử dụng thư viện mã hóa (BCrypt) để so sánh mật khẩu thực tế.
        if (user.getPassword_hash().equals(rawPassword)) {
            return user;
        }

        return null;
    }

    public boolean addUser(User user) {
        if (user.getUsername() == null || user.getUsername().isEmpty()) {
            throw new IllegalArgumentException("Username không được trống.");
        }
        if (userDao.isUsernameExists(user.getUsername())) {
            throw new IllegalStateException("Username đã tồn tại.");
        }
        return userDao.addUser(user);
    }

    public boolean updateUser(User user) {
        if (user.getUser_id() <= 0) {
            throw new IllegalArgumentException("User ID không hợp lệ để cập nhật.");
        }
        return userDao.updateUser(user);
    }

    public boolean deleteUser(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("User ID không hợp lệ.");
        }
        return userDao.deleteUser(id);
    }

    public boolean isUsernameExists(String username) {
        if (username == null || username.isEmpty()) {
            throw new IllegalArgumentException("Username không được trống.");
        }
        return userDao.isUsernameExists(username);
    }

    // ===============================================
    // PHƯƠNG THỨC TRUY VẤN VÀ TÌM KIẾM
    // ===============================================

    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    public User findById(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("User ID không hợp lệ.");
        }
        return userDao.findById(id);
    }

    public User findByCccd(String cccd) {
        if (cccd == null || cccd.isEmpty()) {
            throw new IllegalArgumentException("CCCD không được trống.");
        }
        return userDao.findByCccd(cccd);
    }

    // ⭐ PHƯƠNG THỨC BỔ SUNG CHO CHỨC NĂNG XUẤT FILE CSV
    public List<User> findAllPatients() {
        final int PATIENT_ROLE_ID = 3;
        return getUsersByRole(PATIENT_ROLE_ID);
    }

    // ⭐ PHƯƠNG THỨC BỔ SUNG CHO TÌM KIẾM THEO EMAIL
    public List<User> findByEmail(String email) {
        if (email == null || email.isEmpty()) {
            return Collections.emptyList();
        }
        return userDao.findByEmail(email);
    }

    public List<User> findByName(String name) {
        if (name == null || name.isEmpty()) {
            return userDao.getAllUsers();
        }
        return userDao.findByName(name);
    }

    public List<User> findByGender(String gender) {
        if (gender == null || gender.isEmpty()) {
            return Collections.emptyList();
        }
        return userDao.findByGender(gender);
    }

    public List<User> findByPhone(String phone) {
        if (phone == null || phone.isEmpty()) {
            return Collections.emptyList();
        }
        return userDao.findByPhone(phone);
    }

    public List<User> findByAddress(String address) {
        if (address == null || address.isEmpty()) {
            return Collections.emptyList();
        }
        return userDao.findByAddress(address);
    }

    public List<User> getUsersByRole(int roleId) {
        if (roleId <= 0) {
            return Collections.emptyList();
        }
        return userDao.findByRoleId(roleId);
    }


    public List<User> searchUsers(String searchType, String keyword) {
        if (keyword == null || keyword.trim().isEmpty() || searchType == null || searchType.isEmpty()) {
            return userDao.getAllUsers();
        }

        switch (searchType.toLowerCase()) {
            case "name":
                return userDao.findByName(keyword);
            case "gender":
                return userDao.findByGender(keyword);
            case "phone":
                return userDao.findByPhone(keyword);
            case "address":
                return userDao.findByAddress(keyword);
            case "email": // Thêm trường hợp tìm kiếm theo Email
                return userDao.findByEmail(keyword);
            case "cccd":
                User userByCccd = userDao.findByCccd(keyword);
                if (userByCccd != null) {
                    return Collections.singletonList(userByCccd);
                }
                return Collections.emptyList();
            default:
                return userDao.getAllUsers();
        }
    }
}   