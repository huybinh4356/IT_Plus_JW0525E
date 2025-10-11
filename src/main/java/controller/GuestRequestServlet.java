package controller;

import Dao.GuestRequestDao;
import model.GuestRequest;
import service.GuestRequestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/guest-requests")
public class GuestRequestServlet extends HttpServlet {
    private GuestRequestService guestRequestService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo singleton Service
        this.guestRequestService = GuestRequestService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ✅ Đặt UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "addForm":
                    showAddForm(request, response);
                    break;
                case "editForm":
                    showEditForm(request, response);
                    break;
                case "detail":
                    showDetail(request, response);
                    break;
                case "delete":
                    deleteRequest(request, response);
                    break;
                case "list":
                default:
                    listRequests(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // ✅ Đặt UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "add":
                    insertRequest(request, response);
                    break;
                case "update":
                    updateRequest(request, response);
                    break;
                default:
                    response.sendRedirect("guest-requests");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server error: " + e.getMessage());
        }
    }

    // ==================== PRIVATE HANDLER ====================
    private void listRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<GuestRequest> list = guestRequestService.getAllRequests();
        request.setAttribute("requests", list);
        request.getRequestDispatcher("/WEB-INF/views/guestrequest-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("requestObj", new GuestRequest());
        request.getRequestDispatcher("/WEB-INF/views/guestrequest-add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request, response);
        if (id == -1) return;
        GuestRequest gr = guestRequestService.getRequestById(id);
        if (gr != null) {
            request.setAttribute("requestObj", gr);
            request.getRequestDispatcher("/WEB-INF/views/guestrequest-edit.jsp").forward(request, response);
        } else {
            response.sendRedirect("guest-requests?error=NotFound");
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request, response);
        if (id == -1) return;
        GuestRequest gr = guestRequestService.getRequestById(id);
        if (gr != null) {
            request.setAttribute("requestObj", gr);
            request.getRequestDispatcher("/WEB-INF/views/guestrequest-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("guest-requests?error=NotFound");
        }
    }

    private void insertRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        GuestRequest gr = buildFromRequest(request);
        boolean ok = guestRequestService.addGuestRequest(gr);
        if (ok) {
            response.sendRedirect("guest-requests?message=add_success");
        } else {
            request.setAttribute("error", "Không thêm được yêu cầu");
            request.setAttribute("requestObj", gr);
            request.getRequestDispatcher("/WEB-INF/views/guestrequest-add.jsp").forward(request, response);
        }
    }

    private void updateRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int id = parseId(request, response);
        if (id == -1) return;
        GuestRequest gr = buildFromRequest(request);
        gr.setRequestId(id);
        boolean ok = guestRequestService.updateRequest(gr);
        if (ok) {
            response.sendRedirect("guest-requests?message=update_success");
        } else {
            request.setAttribute("error", "Không cập nhật được yêu cầu");
            request.setAttribute("requestObj", gr);
            request.getRequestDispatcher("/WEB-INF/views/guestrequest-edit.jsp").forward(request, response);
        }
    }

    private void deleteRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = parseId(request, response);
        if (id == -1) return;
        guestRequestService.deleteRequest(id);
        response.sendRedirect("guest-requests?message=delete_success");
    }

    // ==================== HELPER ====================
    private GuestRequest buildFromRequest(HttpServletRequest request) {
        GuestRequest gr = new GuestRequest();
        gr.setFullName(request.getParameter("fullName"));
        gr.setPhone(request.getParameter("phone"));
        gr.setEmail(request.getParameter("email"));
        gr.setCccd(request.getParameter("cccd"));
        gr.setAddress(request.getParameter("address"));
        gr.setMessage(request.getParameter("message"));
        return gr;
    }

    private int parseId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("guest-requests?error=Invalid_id");
            return -1;
        }
        try {
            return Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("guest-requests?error=Invalid_id_format");
            return -1;
        }
    }
}
