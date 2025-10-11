package service;

import Dao.ReviewDao;
import Dao.UserDao;
import Dao.AppointmentDao;
import Dao.ServiceDao;

import model.Reviews;
import model.User;
import model.Action_Service;
import model.Appointments;

import java.time.LocalDateTime;
import java.util.List;

public class ReviewService {
    private final ReviewDao reviewDao;

    private final UserDao userDao;
    private final AppointmentDao appointmentDao;
    private final ServiceDao serviceDao;

    private static ReviewService reviewService;

    private ReviewService() {
        this.reviewDao = ReviewDao.getInstance();
        this.userDao = UserDao.getInstance();
        this.appointmentDao = AppointmentDao.getInstance();
        this.serviceDao = ServiceDao.getInstance();
    }

    public static ReviewService getInstance() {
        if (reviewService == null) {
            reviewService = new ReviewService();
        }
        return reviewService;
    }

    /**
     * Phương thức thêm đánh giá mới, chịu trách nhiệm tìm kiếm các đối tượng Model từ ID thô.
     */
    public boolean addReview(int patientId, Integer serviceId, Integer appointmentId, int rating, String comment) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating phải từ 1 đến 5");
        }

        // 1. TÌM ĐỐI TƯỢNG USER (Bắt buộc)
        User patient = userDao.findById(patientId);
        if (patient == null) {
            throw new IllegalArgumentException("Lỗi: Không tìm thấy Patient với ID: " + patientId);
        }

        // 2. TÌM ĐỐI TƯỢNG SERVICE (Tùy chọn)
        Action_Service service = null;
        if (serviceId != null) {
            service = serviceDao.findById(serviceId);
        }

        // 3. TÌM ĐỐI TƯỢNG APPOINTMENT (Tùy chọn)
        Appointments appointment = null;
        if (appointmentId != null) {
            appointment = appointmentDao.findById(appointmentId);
        }

        // 4. Tạo đối tượng Reviews đầy đủ
        Reviews review = new Reviews();
        review.setPatient(patient);
        review.setService(service);
        review.setAppointment(appointment);
        review.setRating(rating);
        review.setComment(comment);
        review.setCreated_at(LocalDateTime.now());

        // 5. Gọi DAO để lưu vào DB
        return reviewDao.addReview(review);
    }

    public List<Reviews> getAllReviews() {
        return reviewDao.findAll();
    }

    public List<Reviews> getReviewsByPatient(int patientId) {
        return reviewDao.findByPatientId(patientId);
    }

    public List<Reviews> getReviewsByRating(int rating) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating phải từ 1 đến 5");
        }
        return reviewDao.findByRating(rating);
    }

    public List<Reviews> getReviewsByService(int serviceId) {
        return reviewDao.findByServiceId(serviceId);
    }

    public boolean updateReview(Reviews review) {
        if (review.getReview_id() <= 0) {
            throw new IllegalArgumentException("Review ID không hợp lệ");
        }
        if (review.getRating() < 1 || review.getRating() > 5) {
            throw new IllegalArgumentException("Rating phải từ 1 đến 5");
        }

        // Cần đảm bảo các đối tượng khóa ngoại tồn tại trước khi gọi DAO update nếu DAO cần các đối tượng đầy đủ
        // Tuy nhiên, logic Service-DAO này được đơn giản hóa: giả sử DAO chỉ cần ID nếu đối tượng không null.

        return reviewDao.updateReview(review);
    }

    public boolean deleteReview(int reviewId) {
        if (reviewId <= 0) {
            throw new IllegalArgumentException("Review ID không hợp lệ");
        }
        return reviewDao.deleteReview(reviewId);
    }

    public Reviews getReviewById(int reviewId) {
        if (reviewId <= 0) {
            throw new IllegalArgumentException("Review ID không hợp lệ");
        }
        return reviewDao.findById(reviewId);
    }

    // Phương thức tải danh sách dịch vụ bệnh nhân đã sử dụng (được gọi từ Controller cho form ADD/EDIT)
    public List<Action_Service> getServicesByPatientId(Integer patientId) {
        if (patientId == null || patientId <= 0) {
            throw new IllegalArgumentException("Patient ID không hợp lệ.");
        }
        // Giả định ReviewDao có phương thức này
        return reviewDao.getServicesByPatientId(patientId);
    }

    // Phương thức tải danh sách lịch hẹn của bệnh nhân (được gọi từ Controller cho form ADD/EDIT)
    public List<Appointments> getAppointmentsByPatientId(Integer patientId) {
        if (patientId == null || patientId <= 0) {
            throw new IllegalArgumentException("Patient ID không hợp lệ.");
        }
        // Giả định ReviewDao có phương thức này
        return reviewDao.getAppointmentsByPatientId(patientId);
    }
}