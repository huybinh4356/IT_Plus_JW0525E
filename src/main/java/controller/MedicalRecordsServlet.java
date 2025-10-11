package controller;

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
import java.util.List;
import java.util.ArrayList;

@WebServlet("/medical-records")
public class MedicalRecordsServlet extends HttpServlet {
    private MedicalRecordService recordsService;
    private UserService userService;
    private AppointmentService appointmentService;

    private static final String LIST_PAGE = "/WEB-INF/views/records-list.jsp";
    private static final String DETAIL_PAGE = "/WEB-INF/views/records-detail.jsp";
    private static final String ADD_PAGE = "/WEB-INF/views/records-add.jsp";
    private static final String EDIT_PAGE = "/WEB-INF/views/records-edit.jsp";

    @Override
    public void init() throws ServletException {
        super.init();
        this.recordsService = MedicalRecordService.getInstance();
        this.userService = UserService.getInstance();
        this.appointmentService = AppointmentService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "detail":
                    showRecordDetail(req, resp);
                    break;
                case "showAddForm":
                    req.getRequestDispatcher(ADD_PAGE).forward(req, resp);
                    break;
                case "showEditForm":
                    showEditForm(req, resp);
                    break;
                case "patientHistory":
                    showPatientHistory(req, resp);
                    break;
                default: // list
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

    // ================== HANDLERS ==================

    private void listAllRecords(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userRoleId = (Integer) session.getAttribute("userRoleId");
        Integer currentUserId = (Integer) session.getAttribute("userId");

        if (userRoleId == null || currentUserId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<MedicalRecords> records;

        if (userRoleId.intValue() == 3) {
            try {
                records = recordsService.getMedicalRecordsByPatient(currentUserId.intValue());
                req.setAttribute("patientId", currentUserId);
            } catch (Exception e) {
                e.printStackTrace();
                throw new ServletException("Lỗi truy xuất hồ sơ của bệnh nhân.", e);
            }

        } else if (userRoleId.intValue() == 1 || userRoleId.intValue() == 2) {
            String patientIdParam = req.getParameter("patientId");

            if (patientIdParam != null && !patientIdParam.isEmpty()) {
                try {
                    int targetPatientId = Integer.parseInt(patientIdParam);
                    records = recordsService.getMedicalRecordsByPatient(targetPatientId);
                    req.setAttribute("patientId", targetPatientId);
                } catch (NumberFormatException e) {
                    records = recordsService.getAllMedicalRecords();
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new ServletException("Lỗi truy xuất hồ sơ của bệnh nhân cụ thể.", e);
                }
            } else {
                try {
                    records = recordsService.getAllMedicalRecords();
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new ServletException("Lỗi truy xuất tất cả hồ sơ.", e);
                }
            }

        } else {
            records = new ArrayList<>();
            req.setAttribute("error", "Bạn không có quyền xem hồ sơ bệnh án.");
        }

        req.setAttribute("records", records);
        req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
    }

    private void showPatientHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            List<MedicalRecords> history = recordsService.getMedicalRecordsByPatient(patientId);
            req.setAttribute("records", history);
            req.setAttribute("patientId", patientId);
            req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi truy xuất lịch sử bệnh nhân.");
        }
    }

    private void showRecordDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int recordId = Integer.parseInt(req.getParameter("id"));
            MedicalRecords record = recordsService.getMedicalRecordById(recordId);
            if (record != null) {
                req.setAttribute("record", record);
                req.getRequestDispatcher(DETAIL_PAGE).forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ bệnh án.");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID hồ sơ không hợp lệ.");
        }
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int recordId = Integer.parseInt(req.getParameter("id"));
            MedicalRecords record = recordsService.getMedicalRecordById(recordId);
            if (record != null) {
                req.setAttribute("record", record);
                req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ để chỉnh sửa.");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID hồ sơ không hợp lệ.");
        }
    }

    private void addMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // logic thêm hồ sơ
    }

    private void updateMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // logic cập nhật hồ sơ
    }

    private void deleteMedicalRecord(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // logic xóa hồ sơ
    }
}