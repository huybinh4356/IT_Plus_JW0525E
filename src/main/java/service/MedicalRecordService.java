package service;

import Dao.MedicalRecordDao;
import Dao.UserDao;
import Dao.AppointmentDao;
import model.MedicalRecords;
import model.User;
import model.Appointments;

import java.time.LocalDateTime;
import java.util.List;

public class MedicalRecordService {

    // Biến instance duy nhất
    private static MedicalRecordService instance;

    private final MedicalRecordDao medicalRecordDao;
    private final UserDao userDao;
    private final AppointmentDao appointmentDao;


    // Constructor private
    private MedicalRecordService() {
        // Khởi tạo các DAO bằng phương thức getInstance()
        this.medicalRecordDao = MedicalRecordDao.getInstance();
        this.userDao = UserDao.getInstance();
        this.appointmentDao = AppointmentDao.getInstance();
    }

    // Phương thức getInstance
    public static MedicalRecordService getInstance() {
        if (instance == null) {
            instance = new MedicalRecordService();
        }
        return instance;
    }

    // Thao tác CREATE

    // Thêm mới hồ sơ bệnh án.
    public boolean addMedicalRecord(MedicalRecords record) {
        if (record == null) throw new IllegalArgumentException("MedicalRecord không được null.");
        if (record.getPatient_id() == null || record.getPatient_id().getUser_id() <= 0)
            throw new IllegalArgumentException("Patient ID không hợp lệ.");

        // Kiểm tra tính hợp lệ của khóa ngoại (Logic nghiệp vụ)
        if (userDao.findById(record.getPatient_id().getUser_id()) == null) {
            throw new IllegalArgumentException("Bệnh nhân không tồn tại trong hệ thống.");
        }

        // Thiết lập ngày tạo mặc định nếu chưa có
        if (record.getCreated_at() == null) {
            record.setCreated_at(LocalDateTime.now());
        }

        return medicalRecordDao.addMedicalRecord(record);
    }

    // Thao tác READ

    // Lấy toàn bộ hồ sơ bệnh án.
    public List<MedicalRecords> getAllMedicalRecords() {
        return medicalRecordDao.findAll();
    }

    // Lấy hồ sơ theo ID (Cần thêm findById vào DAO)
    public MedicalRecords getMedicalRecordById(int recordId) {
        if (recordId <= 0) throw new IllegalArgumentException("ID hồ sơ không hợp lệ.");
        // Giả định DAO có phương thức findById, nếu không có, bạn cần thêm nó.
        return null;
    }

    // Tìm theo bệnh nhân
    public List<MedicalRecords> getMedicalRecordsByPatient(int patientId) {
        if (patientId <= 0) throw new IllegalArgumentException("Patient ID không hợp lệ.");
        return medicalRecordDao.findByPatientId(patientId);
    }

    // Tìm theo ngày tạo
    public List<MedicalRecords> getMedicalRecordsByDate(LocalDateTime createdAt) {
        if (createdAt == null) throw new IllegalArgumentException("Ngày tạo không hợp lệ.");
        return medicalRecordDao.findByCreatedAt(createdAt);
    }

    // Thao tác UPDATE

    // Cập nhật hồ sơ
    public boolean updateMedicalRecord(MedicalRecords record) {
        if (record == null || record.getRecord_id() <= 0)
            throw new IllegalArgumentException("MedicalRecord hoặc Record ID không hợp lệ.");

        if (record.getPatient_id() == null || record.getPatient_id().getUser_id() <= 0)
            throw new IllegalArgumentException("Patient ID không hợp lệ khi cập nhật.");

        return medicalRecordDao.updateMedicalRecord(record);
    }

    // Thao tác DELETE

    // Xóa hồ sơ
    public boolean deleteMedicalRecord(int recordId) {
        if (recordId <= 0) throw new IllegalArgumentException("ID hồ sơ không hợp lệ.");

        return medicalRecordDao.deleteMedicalRecord(recordId);
    }
}