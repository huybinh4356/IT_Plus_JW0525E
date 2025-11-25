<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Yêu Thích</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo-icon.png" type="image/png">

    <style>
        body {
            background-color: #f0f8ff;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
            overflow-x: hidden;
            /* Dùng hình nền giống các trang khác */
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        /* Card chứa nội dung chính */
        .content-card {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #ff4757; /* Màu đỏ hồng cho Wishlist */
            z-index: 10;
            position: relative;
            height: 100%;
        }

        /* Card bên phải (Form thêm) */
        .form-card-add {
            border-left-color: #28a745; /* Màu xanh lá */
        }

        h1 {
            color: #ff4757;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        h1::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: #ff4757;
            border-radius: 2px;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }

        /* Style cho từng mục Wishlist (Card nằm ngang) */
        .wishlist-item {
            display: flex;
            border: 1px solid #eee;
            border-radius: 10px;
            margin-bottom: 15px;
            padding: 15px;
            transition: all 0.3s ease;
            background: #fff;
        }
        .wishlist-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: #ff4757;
        }

        .wishlist-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .wishlist-content {
            flex: 1;
        }

        .wishlist-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .wishlist-price {
            color: #28a745;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .wishlist-note {
            font-size: 0.9rem;
            color: #666;
            background: #f8f9fa;
            padding: 8px;
            border-radius: 5px;
            margin-top: 8px;
            border-left: 3px solid #ffc107;
        }

        .wishlist-actions {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 8px;
            padding-left: 15px;
            border-left: 1px solid #eee;
        }

        /* Form controls */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px;
        }
        .btn {
            border-radius: 8px;
            font-weight: 500;
        }

        /* Background shapes */
        .background-shape-1, .background-shape-2 {
            position: fixed;
            border-radius: 50%;
            z-index: -1;
            opacity: 0.6;
            filter: blur(80px);
        }
        .background-shape-1 {
            top: -50px; left: -50px; width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(255, 182, 193, 0.4), rgba(255, 192, 203, 0));
        }
        .background-shape-2 {
            bottom: -50px; right: -50px; width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(173, 216, 230, 0.4), rgba(173, 216, 230, 0));
        }
    </style>
</head>
<body>

<div class="background-shape-1"></div>
<div class="background-shape-2"></div>

<div class="container-xl my-5">
    <h1>Danh Sách Yêu Thích <i class="fas fa-heart text-danger"></i></h1>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
        </a>
    </div>

    <div class="row g-4">

        <!-- ================== CỘT TRÁI: DANH SÁCH & TÌM KIẾM (COL-8) ================== -->
        <div class="col-lg-8">
            <div class="content-card">

                <!-- Thanh tìm kiếm -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0 text-danger"><i class="fas fa-list-ul me-2"></i> Dịch vụ đã lưu</h2>
                </div>

                <form action="wishlist" method="get" class="mb-4">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm trong wishlist..." value="${param.keyword}">
                        <button class="btn btn-danger" type="submit"><i class="fas fa-search"></i> Tìm</button>
                    </div>
                </form>

                <!-- Danh sách Wishlist -->
                <c:choose>
                    <c:when test="${empty wishlist}">
                        <div class="alert alert-warning text-center">
                            <i class="far fa-heart fa-2x mb-2"></i><br>
                            Danh sách yêu thích của bạn đang trống.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="w" items="${wishlist}">
                            <div class="wishlist-item">
                                <!-- Ảnh giả định (hoặc lấy từ service) -->
                                <img src="${pageContext.request.contextPath}/assets/images/img_10.png" alt="Service Img" class="wishlist-img">

                                <div class="wishlist-content">
                                    <div class="wishlist-title">${w.service_id.service_name}</div>
                                    <div class="wishlist-price">
                                        <fmt:formatNumber value="${w.service_id.price}" type="number" /> VND
                                    </div>
                                    <small class="text-muted"><i class="far fa-clock"></i> Đã thêm:
                                        <fmt:parseDate value="${w.add_at}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                    </small>

                                    <div class="wishlist-note">
                                        <i class="fas fa-sticky-note text-warning me-1"></i>
                                            ${not empty w.notes ? w.notes : "Chưa có ghi chú"}
                                    </div>
                                </div>

                                <div class="wishlist-actions">
                                    <!-- Nút Sửa (Mở Modal) -->
                                    <button type="button" class="btn btn-sm btn-outline-primary"
                                            data-bs-toggle="modal" data-bs-target="#editModal${w.wishlist_id}">
                                        <i class="fas fa-edit"></i> Sửa
                                    </button>

                                    <!-- Nút Xóa -->
                                    <a href="wishlist?action=delete&wishlistId=${w.wishlist_id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Xóa dịch vụ này khỏi danh sách yêu thích?');">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </a>
                                </div>
                            </div>

                            <!-- MODAL SỬA GHI CHÚ CHO MỖI MỤC -->
                            <div class="modal fade" id="editModal${w.wishlist_id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Cập nhật ghi chú</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form action="wishlist" method="post">
                                            <div class="modal-body">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="wishlistId" value="${w.wishlist_id}">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Dịch vụ:</label>
                                                    <input type="text" class="form-control" value="${w.service_id.service_name}" disabled>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Ghi chú của bạn:</label>
                                                    <textarea name="notes" class="form-control" rows="3">${w.notes}</textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- END MODAL -->

                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ================== CỘT PHẢI: THÊM MỚI (COL-4) ================== -->
        <div class="col-lg-4">
            <div class="content-card form-card-add">
                <h2 class="text-success"><i class="fas fa-plus-circle me-2"></i> Thêm mới</h2>
                <p class="small text-muted">Chọn nhanh dịch vụ bạn quan tâm để lưu lại.</p>
                <hr>

                <form action="wishlist" method="post">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Chọn Dịch vụ</label>
                        <select name="serviceId" class="form-select" required>
                            <option value="" disabled selected>-- Chọn dịch vụ --</option>
                            <!-- Giả sử Servlet gửi 'allServices' sang -->
                            <c:forEach var="s" items="${allServices}">
                                <option value="${s.service_id}">${s.service_name} - <fmt:formatNumber value="${s.price}" type="number"/>đ</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Ghi chú</label>
                        <textarea name="notes" class="form-control" rows="4" placeholder="Ví dụ: Dự định làm vào tháng sau..."></textarea>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save me-2"></i> Lưu vào Wishlist
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>