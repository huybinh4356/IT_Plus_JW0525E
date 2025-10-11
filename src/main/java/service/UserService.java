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

    public User authenticate(String username, String rawPassword) {
        if (username == null || rawPassword == null || username.isEmpty() || rawPassword.isEmpty()) {
            return null;
        }

        User user = userDao.findByUsername(username);

        if (user == null || user.getPassword_hash() == null || user.getPassword_hash().isEmpty()) {
            return null;
        }

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

    // ⭐ PHƯƠNG THỨC MỚI: Lấy danh sách User theo Role ID
    public List<User> getUsersByRole(int roleId) {
        if (roleId <= 0) {
            return Collections.emptyList();
        }
        return userDao.findByRoleId(roleId);
    }
}