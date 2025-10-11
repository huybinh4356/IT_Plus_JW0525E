package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Reviews;
import service.ReviewService;
import model.Appointments;
import model.Action_Service;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private ReviewService reviewService;

    private static final String LIST_PAGE = "/WEB-INF/views/review-list.jsp";
    private static final String DETAIL_PAGE = "/WEB-INF/views/review-detail.jsp";
    private static final String ADD_PAGE = "/WEB-INF/views/review-add.jsp";
    private static final String EDIT_PAGE = "/WEB-INF/views/review-edit.jsp";

    @Override
    public void init() throws ServletException {
        super.init();
        reviewService = ReviewService.getInstance();
    }

    private boolean isAuthorized(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            String action = req.getParameter("action");
            return action == null || "list".equals(action) || "detail".equals(action);
        }

        Integer roleId = (Integer) session.getAttribute("userRoleId");
        return roleId != null && (roleId == 1 || roleId == 2 || roleId == 3);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login?error=access_denied_review");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                showDetail(req, resp);
                break;
            case "showAddForm":
                showAddForm(req, resp);
                break;
            case "showEditForm":
                showEditForm(req, resp);
                break;
            default:
                listReviews(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        Integer roleId = (session != null) ? (Integer) session.getAttribute("userRoleId") : null;

        if (roleId == null || (roleId != 1 && roleId != 3)) {
            resp.sendRedirect(req.getContextPath() + "/login?error=access_denied_action");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add":
                addReview(req, resp);
                break;
            case "update":
                updateReview(req, resp);
                break;
            case "delete":
                deleteReview(req, resp);
                break;
            default:
                resp.sendRedirect("reviews?action=list");
        }
    }

    private void forwardToFormWithReloadedData(HttpServletRequest req, HttpServletResponse resp, String jspPage) throws ServletException, IOException {
        Integer patientId = (Integer) req.getSession().getAttribute("userId");
        if (patientId != null) {
            try {
                List<Action_Service> services = reviewService.getServicesByPatientId(patientId);
                List<Appointments> appointments = reviewService.getAppointmentsByPatientId(patientId);

                req.setAttribute("servicesUsed", services);
                req.setAttribute("appointmentsUsed", appointments);

                if (jspPage.equals(EDIT_PAGE)) {
                    String reviewIdStr = req.getParameter("review_id");
                    if (reviewIdStr != null) {
                        int reviewId = Integer.parseInt(reviewIdStr);
                        Reviews review = reviewService.getReviewById(reviewId);
                        if (review != null) {
                            req.setAttribute("review", review);
                        }
                    }
                }

            } catch (Exception e) {
                System.err.println("Lỗi tái tải dữ liệu dropdown: " + e.getMessage());
            }
        }

        req.getRequestDispatcher(jspPage).forward(req, resp);
    }

    private void listReviews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Reviews> reviews = null;
        try {
            reviews = reviewService.getAllReviews();
            if (reviews != null) {
                reviews = reviews.stream()
                        .filter(r -> r != null)
                        .collect(Collectors.toList());
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi khi tải dữ liệu đánh giá: " + e.getMessage());
        }
        if (reviews == null) {
            reviews = new ArrayList<>();
        }
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Reviews review = reviewService.getReviewById(id);

            if (review != null) {

                // Các dòng "force loading" đã được khôi phục
                if (review.getPatient() != null) {
                    review.getPatient().getUser_id();
                    review.getPatient().getFull_name();
                }
                if (review.getService() != null) {
                    review.getService().getService_id();
                    review.getService().getService_name();
                }
                if (review.getAppointment() != null) {
                    review.getAppointment().getAppointment_id();
                    review.getAppointment().getAppointment_code();
                }

                req.setAttribute("review", review);
                req.getRequestDispatcher(DETAIL_PAGE).forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đánh giá.");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tải chi tiết đánh giá (Có thể do dữ liệu không hợp lệ): " + e.getMessage());
            req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer roleId = (Integer) req.getSession().getAttribute("userRoleId");
        if (roleId == null || roleId != 3) {
            resp.sendRedirect(req.getContextPath() + "/login?error=access_denied_add_review");
            return;
        }

        Integer patientId = (Integer) req.getSession().getAttribute("userId");

        if (patientId != null) {
            try {
                List<Action_Service> services = reviewService.getServicesByPatientId(patientId);
                List<Appointments> appointments = reviewService.getAppointmentsByPatientId(patientId);

                req.setAttribute("servicesUsed", services);
                req.setAttribute("appointmentsUsed", appointments);

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi tải dữ liệu liên quan: " + e.getMessage());
            }
        } else {
            req.setAttribute("error", "Lỗi: Không thể xác định ID Bệnh nhân.");
        }

        req.getRequestDispatcher(ADD_PAGE).forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Reviews review = reviewService.getReviewById(id);

            Integer patientId = (Integer) req.getSession().getAttribute("userId");
            Integer roleId = (Integer) req.getSession().getAttribute("userRoleId");

            if (review != null && review.getPatient() != null) {
                if (roleId != 1 && (roleId != 3 || review.getPatient().getUser_id() != patientId)) {
                    resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa đánh giá này.");
                    return;
                }
            } else if (review == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đánh giá để sửa.");
                return;
            }

            if (patientId != null) {
                try {
                    List<Action_Service> services = reviewService.getServicesByPatientId(patientId);
                    List<Appointments> appointments = reviewService.getAppointmentsByPatientId(patientId);

                    req.setAttribute("servicesUsed", services);
                    req.setAttribute("appointmentsUsed", appointments);

                } catch (Exception e) {
                    e.printStackTrace();
                    req.setAttribute("loadError", "Lỗi tải dữ liệu liên quan cho form sửa: " + e.getMessage());
                }
            }

            req.setAttribute("review", review);
            req.getRequestDispatcher(EDIT_PAGE).forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        }
    }

    private void addReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patient_id"));
            String serviceIdStr = req.getParameter("service_id");
            String appointmentIdStr = req.getParameter("appointment_id");

            Integer serviceId = (serviceIdStr != null && !serviceIdStr.isEmpty()) ? Integer.parseInt(serviceIdStr) : null;
            Integer appointmentId = (appointmentIdStr != null && !appointmentIdStr.isEmpty()) ? Integer.parseInt(appointmentIdStr) : null;

            int rating = Integer.parseInt(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            reviewService.addReview(patientId, serviceId, appointmentId, rating, comment);

            req.getSession().setAttribute("message", "Thêm đánh giá thành công!");
            resp.sendRedirect("reviews?action=list");

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Lỗi: ID hoặc rating không hợp lệ. Vui lòng kiểm tra lại.");
            forwardToFormWithReloadedData(req, resp, ADD_PAGE);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi thêm đánh giá: " + e.getMessage());
            forwardToFormWithReloadedData(req, resp, ADD_PAGE);
        }
    }

    private void updateReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(req.getParameter("review_id"));
            String serviceIdStr = req.getParameter("service_id");
            String appointmentIdStr = req.getParameter("appointment_id");

            Integer serviceId = (serviceIdStr != null && !serviceIdStr.isEmpty()) ? Integer.parseInt(serviceIdStr) : null;
            Integer appointmentId = (appointmentIdStr != null && !appointmentIdStr.isEmpty()) ? Integer.parseInt(appointmentIdStr) : null;

            int rating = Integer.parseInt(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            Reviews existingReview = reviewService.getReviewById(reviewId);
            if (existingReview == null) {
                req.setAttribute("error", "Không tìm thấy đánh giá để cập nhật.");
                forwardToFormWithReloadedData(req, resp, EDIT_PAGE);
                return;
            }

            if (serviceId != null) {
                Action_Service service = new Action_Service();
                service.setService_id(serviceId);
                existingReview.setService(service);
            } else {
                existingReview.setService(null);
            }

            if (appointmentId != null) {
                Appointments appointment = new Appointments();
                appointment.setAppointment_id(appointmentId);
                existingReview.setAppointment(appointment);
            } else {
                existingReview.setAppointment(null);
            }

            existingReview.setRating(rating);
            existingReview.setComment(comment);

            reviewService.updateReview(existingReview);
            req.getSession().setAttribute("message", "Cập nhật đánh giá thành công!");
            resp.sendRedirect("reviews?action=detail&id=" + reviewId);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Lỗi: Dữ liệu không hợp lệ (ID/Rating).");
            forwardToFormWithReloadedData(req, resp, EDIT_PAGE);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
            forwardToFormWithReloadedData(req, resp, EDIT_PAGE);
        }
    }

    private void deleteReview(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            reviewService.deleteReview(id);
            req.getSession().setAttribute("message", "Xóa đánh giá thành công!");
            resp.sendRedirect("reviews?action=list");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        }
    }
}
