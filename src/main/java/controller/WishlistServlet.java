package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Action_Service;
import model.User;
import model.Wishlist;
import service.WishlistService;
import Dao.ServiceDao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistService wishlistService;
    private ServiceDao serviceDao;

    // ĐƯỜNG DẪN CHUẨN (Dựa theo ảnh cấu trúc thư mục bạn gửi)
    private static final String LIST_PAGE = "/WEB-INF/views/wishlist.jsp";
    private static final String LOGIN_PAGE = "/login.jsp";

    @Override
    public void init() throws ServletException {
        super.init();
        wishlistService = new WishlistService();
        serviceDao = new ServiceDao();
    }

    // --- HELPER METHODS (Giống ReviewServlet) ---

    private void sendRedirectWithMessage(HttpServletRequest req, HttpServletResponse resp, String url, String message, boolean isError) throws IOException {
        if (isError) {
            req.getSession().setAttribute("error", message);
        } else {
            req.getSession().setAttribute("message", message);
        }
        resp.sendRedirect(req.getContextPath() + url);
    }

    private boolean isAuthorized(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        // Chỉ cần có User trong session là được phép truy cập (Role nào cũng có wishlist riêng)
        return session != null && session.getAttribute("user") != null;
    }

    // --- MAIN METHODS ---

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        if (!isAuthorized(req)) {
            sendRedirectWithMessage(req, resp, "/login", "Vui lòng đăng nhập để xem danh sách yêu thích.", true);
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "search":
                searchWishlist(req, resp);
                break;
            default:
                listWishlist(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        if (!isAuthorized(req)) {
            sendRedirectWithMessage(req, resp, "/login", "Phiên đăng nhập hết hạn.", true);
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add":
                addToWishlist(req, resp);
                break;
            case "update":
                updateWishlistNote(req, resp);
                break;
            case "delete":
                deleteFromWishlist(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/wishlist?action=list");
        }
    }

    // --- LOGIC METHODS ---

    // Hàm dùng chung để load dữ liệu và forward về JSP
    private void forwardToPageWithData(HttpServletRequest req, HttpServletResponse resp, List<Wishlist> wishlistData) throws ServletException, IOException {
        try {
            // 1. Load danh sách tất cả dịch vụ (cho Dropdown thêm mới)
            List<Action_Service> allServices = serviceDao.getAllServices();
            if (allServices == null) allServices = new ArrayList<>();
            req.setAttribute("allServices", allServices);

            // 2. Set danh sách wishlist hiển thị
            if (wishlistData == null) wishlistData = new ArrayList<>();
            req.setAttribute("wishlist", wishlistData);

            // 3. Update session badge (số lượng trên icon giỏ hàng)
            req.getSession().setAttribute("wishlistSize", wishlistData.size());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải dữ liệu hệ thống: " + e.getMessage());
        }

        req.getRequestDispatcher(LIST_PAGE).forward(req, resp);
    }

    private void listWishlist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            // Lấy danh sách theo ID người dùng
            List<Wishlist> myWishlist = wishlistService.getWishlistByUser(user.getUser_id());
            forwardToPageWithData(req, resp, myWishlist);
        } catch (Exception e) {
            e.printStackTrace();
            sendRedirectWithMessage(req, resp, "/home", "Lỗi khi tải danh sách yêu thích.", true);
        }
    }

    private void searchWishlist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");
            String keyword = req.getParameter("keyword");

            List<Wishlist> searchResult = wishlistService.searchWishlist(user.getUser_id(), keyword);

            // Giữ lại keyword trên thanh tìm kiếm
            req.setAttribute("param.keyword", keyword);
            forwardToPageWithData(req, resp, searchResult);
        } catch (Exception e) {
            e.printStackTrace();
            listWishlist(req, resp); // Fallback về danh sách gốc nếu lỗi
        }
    }

    private void addToWishlist(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String listUrl = "/wishlist";
        try {
            User user = (User) req.getSession().getAttribute("user");

            String serviceIdStr = req.getParameter("serviceId");
            String notes = req.getParameter("notes");

            if (serviceIdStr == null || serviceIdStr.isEmpty()) {
                sendRedirectWithMessage(req, resp, listUrl, "Vui lòng chọn một dịch vụ.", true);
                return;
            }

            int serviceId = Integer.parseInt(serviceIdStr);

            boolean success = wishlistService.addServiceToWishlist(user.getUser_id(), serviceId, notes);

            if (success) {
                sendRedirectWithMessage(req, resp, listUrl, "Đã thêm dịch vụ vào danh sách yêu thích!", false);
            } else {
                sendRedirectWithMessage(req, resp, listUrl, "Dịch vụ này đã có trong danh sách của bạn.", true); // true = error (hoặc warning)
            }

        } catch (NumberFormatException e) {
            sendRedirectWithMessage(req, resp, listUrl, "Dữ liệu dịch vụ không hợp lệ.", true);
        } catch (Exception e) {
            e.printStackTrace();
            sendRedirectWithMessage(req, resp, listUrl, "Lỗi hệ thống khi thêm: " + e.getMessage(), true);
        }
    }

    private void updateWishlistNote(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String listUrl = "/wishlist";
        try {
            String wishlistIdStr = req.getParameter("wishlistId");
            String newNote = req.getParameter("notes");

            if (wishlistIdStr == null || wishlistIdStr.isEmpty()) {
                sendRedirectWithMessage(req, resp, listUrl, "Không tìm thấy ID mục cần sửa.", true);
                return;
            }

            int wishlistId = Integer.parseInt(wishlistIdStr);

            boolean success = wishlistService.updateWishlistNote(wishlistId, newNote);

            if (success) {
                sendRedirectWithMessage(req, resp, listUrl, "Cập nhật ghi chú thành công!", false);
            } else {
                sendRedirectWithMessage(req, resp, listUrl, "Không thể cập nhật ghi chú.", true);
            }

        } catch (NumberFormatException e) {
            sendRedirectWithMessage(req, resp, listUrl, "ID không hợp lệ.", true);
        } catch (Exception e) {
            e.printStackTrace();
            sendRedirectWithMessage(req, resp, listUrl, "Lỗi hệ thống khi cập nhật.", true);
        }
    }

    private void deleteFromWishlist(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String listUrl = "/wishlist";
        try {
            String wishlistIdStr = req.getParameter("wishlistId");

            if (wishlistIdStr == null || wishlistIdStr.isEmpty()) {
                sendRedirectWithMessage(req, resp, listUrl, "Không tìm thấy ID mục cần xóa.", true);
                return;
            }

            int wishlistId = Integer.parseInt(wishlistIdStr);

            boolean success = wishlistService.removeWishlistItem(wishlistId);

            if (success) {
                sendRedirectWithMessage(req, resp, listUrl, "Đã xóa khỏi danh sách yêu thích.", false);
            } else {
                sendRedirectWithMessage(req, resp, listUrl, "Xóa thất bại.", true);
            }

        } catch (NumberFormatException e) {
            sendRedirectWithMessage(req, resp, listUrl, "ID không hợp lệ.", true);
        } catch (Exception e) {
            e.printStackTrace();
            sendRedirectWithMessage(req, resp, listUrl, "Lỗi hệ thống khi xóa.", true);
        }
    }
}