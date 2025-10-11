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

    private static MedicalRecordService instance;

    private final MedicalRecordDao medicalRecordDao;
    private final UserDao userDao;
    private final AppointmentDao appointmentDao;


    private MedicalRecordService() {
        this.medicalRecordDao = MedicalRecordDao.getInstance();
        this.userDao = UserDao.getInstance();
        this.appointmentDao = AppointmentDao.getInstance();
    }

    public static MedicalRecordService getInstance() {
        if (instance == null) {
            instance = new MedicalRecordService();
        }
        return instance;
    }

    public boolean addMedicalRecord(MedicalRecords record) {
        if (record == null) throw new IllegalArgumentException("MedicalRecord không được null.");
        if (record.getPatient_id() == null || record.getPatient_id().getUser_id() <= 0)
            throw new IllegalArgumentException("Patient ID không hợp lệ.");

        if (userDao.findById(record.getPatient_id().getUser_id()) == null) {
            throw new IllegalArgumentException("Bệnh nhân không tồn tại trong hệ thống.");
        }

        if (record.getCreated_at() == null) {
            record.setCreated_at(LocalDateTime.now());
        }

        return medicalRecordDao.addMedicalRecord(record);
    }

    public List<MedicalRecords> getAllMedicalRecords() {
        List<MedicalRecords> records = medicalRecordDao.findAll();
        for (MedicalRecords record : records) {
            loadForeignKeys(record);
        }
        return records;
    }

    public MedicalRecords getMedicalRecordById(int recordId) {
        if (recordId <= 0) throw new IllegalArgumentException("ID hồ sơ không hợp lệ.");

        MedicalRecords record = medicalRecordDao.findById(recordId);

        if (record != null) {
            loadForeignKeys(record);
        }

        return record;
    }

    private void loadForeignKeys(MedicalRecords record) {
        if (record.getPatient_id() != null && record.getPatient_id().getUser_id() > 0) {
            User patient = userDao.findById(record.getPatient_id().getUser_id());
            record.setPatient_id(patient);
        }

        if (record.getAppointment_id() != null && record.getAppointment_id().getAppointment_id() > 0) {
            Appointments appointment = appointmentDao.findById(record.getAppointment_id().getAppointment_id());
            record.setAppointment_id(appointment);
        }
    }


    public List<MedicalRecords> getMedicalRecordsByPatient(int patientId) {
        if (patientId <= 0) throw new IllegalArgumentException("Patient ID không hợp lệ.");
        List<MedicalRecords> records = medicalRecordDao.findByPatientId(patientId);
        for (MedicalRecords record : records) {
            loadForeignKeys(record);
        }
        return records;
    }

    public List<MedicalRecords> getMedicalRecordsByDate(LocalDateTime createdAt) {
        if (createdAt == null) throw new IllegalArgumentException("Ngày tạo không hợp lệ.");
        return medicalRecordDao.findByCreatedAt(createdAt);
    }

    public boolean updateMedicalRecord(MedicalRecords record) {
        if (record == null || record.getRecord_id() <= 0)
            throw new IllegalArgumentException("MedicalRecord hoặc Record ID không hợp lệ.");

        if (record.getPatient_id() == null || record.getPatient_id().getUser_id() <= 0)
            throw new IllegalArgumentException("Patient ID không hợp lệ khi cập nhật.");

        return medicalRecordDao.updateMedicalRecord(record);
    }

    public boolean deleteMedicalRecord(int recordId) {
        if (recordId <= 0) throw new IllegalArgumentException("ID hồ sơ không hợp lệ.");

        return medicalRecordDao.deleteMedicalRecord(recordId);
    }
}