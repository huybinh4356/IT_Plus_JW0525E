package service;

import Dao.WishlistDao;
import model.Wishlist;
import java.util.List;

public class WishlistService {

    private WishlistDao wishlistDao;

    public WishlistService() {
        this.wishlistDao = new WishlistDao();
    }

    public List<Wishlist> getWishlistByUser(int userId) {
        return wishlistDao.getWishlistByUserId(userId);
    }

    public boolean addServiceToWishlist(int userId, int serviceId, String notes) {
        if (notes == null) notes = "";
        // Kiểm tra trùng trong Service hoặc để DAO lo cũng được
        return wishlistDao.addToWishlist(userId, serviceId, notes);
    }

    public boolean removeWishlistItem(int wishlistId) {
        return wishlistDao.deleteWishlistItem(wishlistId);
    }

    // (MỚI) Cập nhật ghi chú
    public boolean updateWishlistNote(int wishlistId, String newNote) {
        return wishlistDao.updateNote(wishlistId, newNote);
    }

    // (MỚI) Tìm kiếm
    public List<Wishlist> searchWishlist(int userId, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getWishlistByUser(userId);
        }
        return wishlistDao.searchWishlist(userId, keyword);
    }
}