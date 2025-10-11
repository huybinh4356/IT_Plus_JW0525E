package service;

import Dao.AppointmentDao;
import model.Appointments;
import model.Action_Service;
import Dao.ServiceDao;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppointmentService {

    private static final Logger logger = Logger.getLogger(AppointmentService.class.getName());
    private final AppointmentDao appointmentDao;
    private final ServiceDao serviceDao;

    private static AppointmentService appointmentService;

    private AppointmentService() {
        this.appointmentDao = AppointmentDao.getInstance();
        this.serviceDao = ServiceDao.getInstance();
    }

    public static AppointmentService getInstance() {
        if (appointmentService == null) {
            appointmentService = new AppointmentService();
        }
        return appointmentService;
    }

    public List<Action_Service> getAllServices() {
        try {
            return serviceDao.findAll();
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi lấy tất cả dịch vụ.", e);
            throw new RuntimeException("Không thể tải danh sách dịch vụ do lỗi hệ thống.", e);
        }
    }

    public List<Appointments> getAllAppointments() {
        try {
            return appointmentDao.findAll();
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi lấy tất cả lịch hẹn.", e);
            throw new RuntimeException("Không thể tải danh sách lịch hẹn do lỗi hệ thống.", e);
        }
    }

    public Appointments getAppointmentById(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Appointment ID không hợp lệ.");
        }
        try {
            return appointmentDao.findById(id);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo ID: " + id, e);
            throw new RuntimeException("Không thể tìm lịch hẹn do lỗi hệ thống.", e);
        }
    }

    public Appointments getAppointmentByCode(String code) {
        if (code == null || code.isBlank()) {
            throw new IllegalArgumentException("Mã lịch hẹn không được trống.");
        }
        try {
            return appointmentDao.findByAppointmentCode(code);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo mã: " + code, e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByPatient(int patientId) {
        if (patientId <= 0) {
            throw new IllegalArgumentException("Patient ID không hợp lệ.");
        }
        try {
            return appointmentDao.findByPatientId(patientId);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo bệnh nhân ID: " + patientId, e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByService(int serviceId) {
        if (serviceId <= 0) {
            throw new IllegalArgumentException("Service ID không hợp lệ.");
        }
        try {
            return appointmentDao.findByServiceId(serviceId);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo Service ID: " + serviceId, e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByDate(LocalDate date) {
        if (date == null) {
            throw new IllegalArgumentException("Ngày không được trống.");
        }
        try {
            return appointmentDao.findByAppointmentDate(date);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo ngày.", e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByTime(LocalTime time) {
        if (time == null) {
            throw new IllegalArgumentException("Giờ không được trống.");
        }
        try {
            return appointmentDao.findByAppointmentTime(time);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo giờ.", e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByDateAndPatient(LocalDate date, int patientId) {
        if (date == null) {
            throw new IllegalArgumentException("Ngày không được trống.");
        }
        if (patientId <= 0) {
            throw new IllegalArgumentException("Patient ID không hợp lệ.");
        }
        try {
            return appointmentDao.findByDateAndPatient(date, patientId);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo ngày và bệnh nhân.", e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public List<Appointments> getAppointmentsByStatus(String status) {
        if (status == null || status.isBlank()) {
            throw new IllegalArgumentException("Trạng thái không được trống.");
        }
        try {
            return appointmentDao.findByStatus(status.toUpperCase());
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi tìm lịch hẹn theo trạng thái.", e);
            throw new RuntimeException("Lỗi hệ thống khi tìm lịch hẹn.", e);
        }
    }

    public boolean addAppointment(Appointments appointment) {
        if (appointment == null) {
            throw new IllegalArgumentException("Đối tượng lịch hẹn không được rỗng.");
        }

        if (appointment.getAppointment_date() == null || appointment.getAppointment_time() == null) {
            throw new IllegalArgumentException("Ngày và giờ hẹn không được trống.");
        }

        if (appointment.getPatient_id() == null || appointment.getPatient_id().getUser_id() <= 0) {
            throw new IllegalArgumentException("Thông tin bệnh nhân không hợp lệ (Missing Patient ID).");
        }

        if (appointment.getService_id() == null || appointment.getService_id().getService_id() <= 0) {
            throw new IllegalArgumentException("Thông tin dịch vụ không hợp lệ (Missing Service ID).");
        }

        if (appointment.getStatus() != null && !appointment.getStatus().isBlank()) {
            appointment.setStatus(appointment.getStatus().toUpperCase());
        } else {
            appointment.setStatus("PENDING");
        }

        try {
            if (!appointmentDao.isTimeSlotAvailable(
                    appointment.getAppointment_date(),
                    appointment.getAppointment_time(),
                    appointment.getPatient_id().getUser_id())) {
                throw new IllegalStateException("Khung giờ này đã được đặt hoặc bệnh nhân đã có lịch hẹn khác.");
            }

            return appointmentDao.addAppointment(appointment);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi thêm lịch hẹn.", e);
            throw new RuntimeException("Thêm lịch hẹn thất bại do lỗi cơ sở dữ liệu: " + e.getMessage(), e);
        }
    }

    public boolean updateAppointment(Appointments appointment) {
        if (appointment == null) {
            throw new IllegalArgumentException("Đối tượng lịch hẹn không được rỗng.");
        }

        if (appointment.getAppointment_id() <= 0) {
            throw new IllegalArgumentException("Appointment ID không hợp lệ.");
        }

        if (appointment.getPatient_id() == null || appointment.getPatient_id().getUser_id() <= 0) {
            throw new IllegalArgumentException("Thông tin bệnh nhân không hợp lệ khi cập nhật.");
        }

        if (appointment.getService_id() == null || appointment.getService_id().getService_id() <= 0) {
            throw new IllegalArgumentException("Thông tin dịch vụ không hợp lệ khi cập nhật.");
        }

        if (appointment.getStatus() != null && !appointment.getStatus().isBlank()) {
            appointment.setStatus(appointment.getStatus().toUpperCase());
        } else {
            throw new IllegalArgumentException("Trạng thái lịch hẹn không được trống khi cập nhật.");
        }

        try {
            return appointmentDao.updateAppointment(appointment);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi cập nhật lịch hẹn ID: " + appointment.getAppointment_id(), e);
            throw new RuntimeException("Cập nhật lịch hẹn thất bại do lỗi cơ sở dữ liệu: " + e.getMessage(), e);
        }
    }

    public boolean updateStatus(int id, String status) {
        if (id <= 0) {
            throw new IllegalArgumentException("Appointment ID không hợp lệ.");
        }
        if (status == null || status.isBlank()) {
            throw new IllegalArgumentException("Trạng thái không được trống.");
        }

        String upperStatus = status.toUpperCase();

        try {
            return appointmentDao.updateAppointmentStatus(id, upperStatus);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi cập nhật trạng thái lịch hẹn ID: " + id, e);
            throw new RuntimeException("Cập nhật trạng thái thất bại do lỗi cơ sở dữ liệu: " + e.getMessage(), e);
        }
    }

    public boolean deleteAppointment(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Appointment ID không hợp lệ.");
        }
        try {
            return appointmentDao.deleteAppointment(id);
        } catch (RuntimeException e) {
            logger.log(Level.SEVERE, "Lỗi hệ thống khi xóa lịch hẹn ID: " + id, e);
            throw new RuntimeException("Xóa lịch hẹn thất bại do lỗi cơ sở dữ liệu: " + e.getMessage(), e);
        }
    }
}