package service;

import Dao.GuestRequestDao;
import model.GuestRequest;

import java.util.List;

public class GuestRequestService {
    private final GuestRequestDao guestRequestDao;
    private static GuestRequestService guestRequestService;
    
    private GuestRequestService() {
        this.guestRequestDao = GuestRequestDao.getQuestRequestDao();
    }
    public static GuestRequestService getInstance() {
        if (guestRequestService == null) {
            guestRequestService = new GuestRequestService();
        }
        return guestRequestService;
    }

    // Thêm yêu cầu của khách (có kiểm tra dữ liệu cơ bản)
    public boolean addGuestRequest(GuestRequest request) {
        if (request == null) throw new IllegalArgumentException("GuestRequest không được null");
        if (request.getFullName() == null || request.getFullName().isBlank())
            throw new IllegalArgumentException("Tên không được để trống");
        if (request.getPhone() == null || request.getPhone().isBlank())
            throw new IllegalArgumentException("Số điện thoại không được để trống");

        // Có thể thêm check trùng số điện thoại hoặc CCCD
        GuestRequest existingByPhone = guestRequestDao.findByPhone(request.getPhone());
        if (existingByPhone != null) {
            throw new IllegalStateException("Số điện thoại này đã tồn tại trong hệ thống");
        }

        return guestRequestDao.addGuestRequest(request);
    }

    // Lấy tất cả yêu cầu
    public List<GuestRequest> getAllRequests() {
        return guestRequestDao.findAll();
    }

    // Tìm theo ID
    public GuestRequest getRequestById(int id) {
        if (id <= 0) throw new IllegalArgumentException("ID không hợp lệ");
        return guestRequestDao.findById(id);
    }

    // Tìm theo họ tên
    public List<GuestRequest> searchByFullName(String name) {
        if (name == null || name.isBlank()) return List.of();
        return guestRequestDao.findByFullName(name);
    }

    // Tìm theo CCCD
    public GuestRequest getRequestByCCCD(String cccd) {
        if (cccd == null || cccd.isBlank()) return null;
        return guestRequestDao.findByCCCD(cccd);
    }

    // Tìm theo số điện thoại
    public GuestRequest getRequestByPhone(String phone) {
        if (phone == null || phone.isBlank()) return null;
        return guestRequestDao.findByPhone(phone);
    }

    // Cập nhật yêu cầu
    public boolean updateRequest(GuestRequest request) {
        if (request == null || request.getRequestId() <= 0)
            throw new IllegalArgumentException("Thông tin request không hợp lệ");
        return guestRequestDao.updateGuestRequest(request);
    }

    // Xóa yêu cầu
    public boolean deleteRequest(int id) {
        if (id <= 0) throw new IllegalArgumentException("ID không hợp lệ");
        return guestRequestDao.deleteGuestRequest(id);
    }
}
