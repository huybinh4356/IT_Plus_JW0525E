<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đánh giá</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        body {
            background-color: #f0f8ff;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
            padding-top: 50px;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: auto;
        }

        .container {
            max-width: 1200px;
            width: 100%;
        }

        .card-table {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #ffc107;
            z-index: 10;
            position: relative;
        }

        h1 {
            color: #007bff;
            font-weight: 700;
            position: relative;
            margin-bottom: 0;
        }

        table {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }
        thead {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            font-weight: 600;
        }
        thead th {
            padding: 15px 12px;
        }
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        td {
            font-size: 0.9rem;
            vertical-align: middle;
        }

        .btn-primary {
            background: #28a745;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #1e7e34;
        }

        .btn-login-to-add {
            background: #ffc107;
            border: none;
            color: #333;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(255, 193, 7, 0.3);
            transition: all 0.3s ease;
        }
        .btn-login-to-add:hover {
            background: #e0a800;
            color: #333;
        }

        .btn-outline-secondary {
            border-radius: 8px;
            font-weight: 500;
        }

        .btn-sm {
            padding: 6px 10px;
            font-size: 0.8rem;
            border-radius: 6px;
        }
        .btn-info { background-color: #17a2b8; border-color: #17a2b8; }
        .btn-warning { background-color: #ffc107; border-color: #ffc107; color: #333; }
        .btn-danger { background-color: #dc3545; border-color: #dc3545; }

        .rating-stars {
            color: #ffc107;
            font-weight: 600;
        }

        .background-shape-1 {
            position: fixed;
            top: -100px;
            left: -100px;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(173, 216, 230, 0.3), rgba(173, 216, 230, 0));
            border-radius: 50%;
            filter: blur(100px);
            z-index: -1;
            animation: floatShape 10s ease-in-out infinite alternate;
        }

        .background-shape-2 {
            position: fixed;
            bottom: -150px;
            right: -150px;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(135, 206, 235, 0.25), rgba(135, 206, 235, 0));
            border-radius: 50%;
            filter: blur(120px);
            z-index: -1;
            animation: floatShape 12s ease-in-out infinite alternate-reverse;
        }

        @keyframes floatShape {
            0% { transform: translate(0, 0); }
            50% { transform: translate(20px, 20px); }
            100% { transform: translate(0, 0); }
        }
    </style>
</head>
<body>
<div class="background-shape-1"></div>
<div class="background-shape-2"></div>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div class="d-flex align-items-center">
            <a href="<c:url value='/home'/>" class="btn btn-secondary shadow-sm">
                <i class="fas fa-home me-2"></i> Trang chủ
            </a>
            <h1 class="h3 d-inline align-middle mb-0 ms-4">
                <i class="fas fa-star me-2 text-warning"></i> Danh sách đánh giá
            </h1>
        </div>

        <c:choose>
            <c:when test="${not empty sessionScope.userRoleId}">
                <a href="reviews?action=showAddForm" class="btn btn-primary shadow">
                    <i class="fas fa-plus me-2"></i> Thêm đánh giá mới
                </a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login'/>" class="btn btn-login-to-add shadow">
                    <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập để thêm
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fas fa-check-circle me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card card-table">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0 align-middle">
                    <thead>
                    <tr>
                        <th style="width: 5%;">ID</th>
                        <th style="width: 15%;">Bệnh nhân ID</th>
                        <th style="width: 15%;">Dịch vụ ID</th>
                        <th style="width: 10%;">Rating</th>
                        <th style="width: 35%;">Bình luận</th>
                        <th style="width: 20%;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <c:if test="${review != null}">
                                        <td>${review.review_id}</td>
                                        <td><span class="badge bg-secondary">${review.patient.user_id}</span></td>
                                        <td>
                                            <c:if test="${not empty review.service}">
                                                <span class="badge bg-info">${review.service.service_id}</span>
                                            </c:if>
                                            <c:if test="${empty review.service}">
                                                <span class="text-muted small">N/A</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="rating-stars">${review.rating} ⭐</span>
                                        </td>
                                        <td>
                                            <span class="d-inline-block text-truncate" style="max-width: 250px;">
                                                <c:if test="${not empty review.comment}">${review.comment}</c:if>
                                                <c:if test="${empty review.comment}"><span class="text-muted fst-italic">Không có bình luận</span></c:if>
                                            </span>
                                        </td>
                                        <td class="text-nowrap">
                                            <a href="reviews?action=detail&id=${review.review_id}" class="btn btn-sm btn-info me-1">
                                                <i class="fas fa-info-circle"></i> Xem
                                            </a>

                                            <c:if test="${sessionScope.userRoleId == 1}">
<%--                                                <a href="reviews?action=showEditForm&id=${review.review_id}" class="btn btn-sm btn-warning me-1">--%>
<%--                                                    <i class="fas fa-edit"></i> Sửa--%>
<%--                                                </a>--%>
                                                <a href="reviews?action=delete&id=${review.review_id}" class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc muốn xóa đánh giá ID: ${review.review_id} này không?');">
                                                    <i class="fas fa-trash-alt"></i> Xóa
                                                </a>
                                            </c:if>
                                        </td>
                                    </c:if>
                                    <c:if test="${review == null}">
                                        <td colspan="6" class="text-center text-danger fst-italic">Lỗi dữ liệu: Đối tượng đánh giá bị thiếu.</td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <i class="fas fa-exclamation-circle me-2"></i> Hiện chưa có đánh giá nào hoặc có lỗi tải dữ liệu.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>