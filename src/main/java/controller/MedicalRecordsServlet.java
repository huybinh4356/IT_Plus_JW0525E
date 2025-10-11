package controller;

import jakarta.servlet.UnavailableException;
import model.MedicalRecords;
import model.User;
import model.Appointments;
import service.MedicalRecordService;
import service.UserService;
import service.AppointmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Collections;

@WebServlet("/medical-records")
public class MedicalRecordsServlet extends HttpServlet {
    private MedicalRecordService recordsService;
    private UserService userService;
    private AppointmentService appointmentService;

    private static final String LIST_PAGE = "/WEB-INF/views/records-list.jsp";
    private static final String DETAIL_PAGE = "/WEB-INF/views/records-detail.jsp";
    private static final String ADD_PAGE = "/WEB-INF/views/records-add.jsp";
    private static final String EDIT_PAGE = "/WEB-INF/views/records-edit.jsp";

    private static final int PATIENT_ROLE_ID = 3;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.recordsService = MedicalRecordService.getInstance();
            this.userService = UserService.getInstance();
            this.appointmentService = AppointmentService.getInstance();
        } catch (Exception e) {
            System.err.println("LỖI KHỞI TẠO SERVICE TRONG MedicalRecordsServlet:");
            e.printStackTrace();
            throw new UnavailableException("Không thể khởi tạo các Service: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        req.setCharacterEncoding("UTF-8");

        try {
            switch (action) {
                case "detail":
                    showRecordDetail(req, resp);
                    break;
                case "showAddForm":
                    showAddForm(req, resp);
                    break;
                case "showEditForm":
                    showEditForm(req, resp);
                    break;
                case "patientHistory":
                    showPatientHistory(req, resp);
                    break;
                case "list":
                default:
                    listAllRecords(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");

        try {
            switch (action) {
                case "add":
                    addMedicalRecord(req, resp);
                    break;
                case "update":
                    updateMedicalRecord(req, resp);
                    break;
                case "delete":
                    deleteMedicalRecord(req, resp);
                    break;
                default:
                    resp.sendRedirect("medical-records?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
        }
    }

    private void listAllRecords(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<MedicalRecords> records = Collections.emptyList();
        try {
            records = recordsService.getAllMedicalRecords();
        } catch (Exception e) {
            System.err.println("LỖI KHI TẢI DANH SÁCH HỒ SƠ Y TẾ:");
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: Không thể tải danh sách hồ sơ y tế từ Cơ sở dữ liệu.");
        }

        req.setAttribute("records", records);
        req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
    }

    private void showRecordDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String recordIdParam = req.getParameter("id");

        try {
            if (recordIdParam == null || recordIdParam.isEmpty()) {
                throw new IllegalArgumentException("Thiếu ID hồ sơ y tế.");
            }

            int recordId = Integer.parseInt(recordIdParam);
            MedicalRecords record = recordsService.getMedicalRecordById(recordId);

            if (record == null) {
                throw new Exception("Không tìm thấy Hồ sơ y tế có ID: " + recordId);
            }

            req.setAttribute("record", record);
            req.getRequestDispatcher(DETAIL_PAGE).forward(req, resp);

        } catch (NumberFormatException e) {
            System.err.println("Lỗi NumberFormat: " + e.getMessage());
            resp.sendRedirect("medical-records?action=list&message=invalidId");
        } catch (Exception e) {
            System.err.println("LỖI KHI XEM CHI TIẾT HỒ SƠ: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("medical-records?action=list&message=detailError");
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<User> patients = userService.getUsersByRole(PATIENT_ROLE_ID);
            req.setAttribute("patients", patients);
            req.getRequestDispatcher(ADD_PAGE).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tải danh sách bệnh nhân từ hệ thống.");
            req.getRequestDispatcher(ADD_PAGE).forward(req, resp);
        }
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String recordIdParam = req.getParameter("id");

        try {
            if (recordIdParam == null || recordIdParam.isEmpty()) {
                resp.sendRedirect("medical-records?action=list&message=missingId");
                return;
            }

            int recordId = Integer.parseInt(recordIdParam);
            MedicalRecords existingRecord = recordsService.getMedicalRecordById(recordId);

            if (existingRecord == null) {
                resp.sendRedirect("medical-records?action=list&message=recordNotFound");
                return;
            }

            List<User> patients = userService.getUsersByRole(PATIENT_ROLE_ID);

            req.setAttribute("record", existingRecord);
            req.setAttribute("patients", patients);

            req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("medical-records?action=list&message=invalidIdFormat");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải form chỉnh sửa: " + e.getMessage());
        }
    }

    private void addMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String patientIdParam = req.getParameter("patient_id");
        String appointmentIdParam = req.getParameter("appointment_id");
        String diagnosis = req.getParameter("diagnosis");
        String treatment = req.getParameter("treatment");
        String notes = req.getParameter("notes");

        try {
            if (patientIdParam == null || patientIdParam.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn bệnh nhân.");
            }
            int patientId = Integer.parseInt(patientIdParam);

            MedicalRecords newRecord = new MedicalRecords();
            User patient = new User();
            patient.setUser_id(patientId);
            newRecord.setPatient_id(patient);

            if (appointmentIdParam != null && !appointmentIdParam.isEmpty()) {
                Appointments app = new Appointments();
                app.setAppointment_id(Integer.parseInt(appointmentIdParam));
                newRecord.setAppointment_id(app);
            }

            newRecord.setDiagnosis(diagnosis);
            newRecord.setTreatment(treatment);
            newRecord.setNotes(notes);
            newRecord.setCreated_at(LocalDateTime.now());

            boolean success = recordsService.addMedicalRecord(newRecord);

            if (success) {
                resp.sendRedirect("medical-records?message=addSuccess");
            } else {
                req.setAttribute("error", "Lỗi lưu trữ: Không thể lưu hồ sơ vào cơ sở dữ liệu. Vui lòng thử lại.");
                loadFormAndForward(req, resp, patientIdParam, appointmentIdParam, diagnosis, treatment, notes);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Lỗi dữ liệu: ID bệnh nhân/lịch hẹn không hợp lệ.");
            loadFormAndForward(req, resp, patientIdParam, appointmentIdParam, diagnosis, treatment, notes);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Lỗi nghiệp vụ: " + e.getMessage());
            loadFormAndForward(req, resp, patientIdParam, appointmentIdParam, diagnosis, treatment, notes);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi Server không xác định: " + e.getMessage());
            loadFormAndForward(req, resp, patientIdParam, appointmentIdParam, diagnosis, treatment, notes);
        }
    }

    private void updateMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String recordIdParam = req.getParameter("record_id");
        String patientIdParam = req.getParameter("patient_id");
        String appointmentIdParam = req.getParameter("appointment_id");
        String diagnosis = req.getParameter("diagnosis");
        String treatment = req.getParameter("treatment");
        String notes = req.getParameter("notes");

        try {
            if (recordIdParam == null || recordIdParam.isEmpty() || patientIdParam == null || patientIdParam.isEmpty()) {
                throw new IllegalArgumentException("Thiếu ID hồ sơ hoặc ID bệnh nhân.");
            }

            MedicalRecords updatedRecord = new MedicalRecords();
            updatedRecord.setRecord_id(Integer.parseInt(recordIdParam));

            User patient = new User();
            patient.setUser_id(Integer.parseInt(patientIdParam));
            updatedRecord.setPatient_id(patient);

            updatedRecord.setDiagnosis(diagnosis);
            updatedRecord.setTreatment(treatment);
            updatedRecord.setNotes(notes);

            if (appointmentIdParam != null && !appointmentIdParam.isEmpty()) {
                Appointments app = new Appointments();
                app.setAppointment_id(Integer.parseInt(appointmentIdParam));
                updatedRecord.setAppointment_id(app);
            } else {
                updatedRecord.setAppointment_id(null);
            }

            boolean success = recordsService.updateMedicalRecord(updatedRecord);

            if (success) {
                resp.sendRedirect("medical-records?action=detail&id=" + recordIdParam + "&message=updateSuccess");
            } else {
                req.setAttribute("error", "Cập nhật hồ sơ thất bại. Dữ liệu không đổi hoặc lỗi CSDL.");
                req.setAttribute("record", recordsService.getMedicalRecordById(Integer.parseInt(recordIdParam)));
                List<User> patients = userService.getUsersByRole(PATIENT_ROLE_ID);
                req.setAttribute("patients", patients);
                req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Dữ liệu ID không hợp lệ.");
            req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Lỗi nghiệp vụ: " + e.getMessage());
            req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi Server không xác định: " + e.getMessage());
            req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);
        }
    }

    private void deleteMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String recordIdParam = req.getParameter("id");

        try {
            if (recordIdParam == null || recordIdParam.isEmpty()) {
                resp.sendRedirect("medical-records?action=list&message=missingIdForDelete");
                return;
            }

            int recordId = Integer.parseInt(recordIdParam);

            boolean success = recordsService.deleteMedicalRecord(recordId);

            if (success) {
                resp.sendRedirect("medical-records?action=list&message=deleteSuccess");
            } else {
                resp.sendRedirect("medical-records?action=list&message=deleteFailed");
            }

        } catch (NumberFormatException e) {
            resp.sendRedirect("medical-records?action=list&message=invalidIdFormat");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("medical-records?action=list&message=systemError");
        }
    }

    private void showPatientHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String patientIdParam = req.getParameter("patientId");
        List<MedicalRecords> records = Collections.emptyList();

        try {
            if (patientIdParam == null || patientIdParam.isEmpty()) {
                resp.sendRedirect("medical-records?action=list");
                return;
            }

            int patientId = Integer.parseInt(patientIdParam);
            records = recordsService.getMedicalRecordsByPatient(patientId);

            req.setAttribute("records", records);
            req.setAttribute("patientId", patientId);

            req.getRequestDispatcher(LIST_PAGE).forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("medical-records?action=list&message=invalidPatientId");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tải lịch sử bệnh án.");
            req.setAttribute("records", Collections.emptyList());
            req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
        }
    }

    private void loadFormAndForward(HttpServletRequest req, HttpServletResponse resp, String patientIdParam, String appointmentIdParam, String diagnosis, String treatment, String notes) throws ServletException, IOException {
        req.setAttribute("old_patient_id", patientIdParam);
        req.setAttribute("old_appointment_id", appointmentIdParam);
        req.setAttribute("old_diagnosis", diagnosis);
        req.setAttribute("old_treatment", treatment);
        req.setAttribute("old_notes", notes);

        List<User> patients = userService.getUsersByRole(PATIENT_ROLE_ID);
        req.setAttribute("patients", patients);

        req.getRequestDispatcher(ADD_PAGE).forward(req, resp);
    }
}