<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khôi phục Mật khẩu - DreamTooth</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container-box {
            width: 100%;
            max-width: 500px;
            padding: 30px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .contact-info {
            font-size: 0.9em;
            margin-top: 20px;
            padding: 15px;
            background-color: #f1f7fe;
            border-radius: 8px;
            border-left: 5px solid #0d6efd;
        }
    </style>
</head>
<body>

<div class="container-box">
    <h3 class="text-center mb-4 text-primary">Đã Gửi Yêu Cầu Khôi Phục Mật Khẩu</h3>

    <%-- 1. HIỂN THỊ THÔNG BÁO (SUCCESS HOẶC ERROR) --%>
    <c:if test="${not empty requestScope.message}">
        <div class="alert alert-success" role="alert">
            <span class="fw-bold">Thành công!</span> ${requestScope.message}
        </div>

        <%-- THÔNG TIN LIÊN HỆ VÀ NÚT QUAY VỀ KHI THÀNH CÔNG --%>
        <div class="contact-info text-center">
            <p class="fw-bold mb-1 text-danger">⚠️ Cần hỗ trợ khẩn cấp?</p>
            <p>Phản ánh hoặc liên hệ hỗ trợ qua:</p>
            <p class="mb-1">
                <span class="fw-bold">Hotline:</span>
                <a href="tel:0123456789">0123456789</a> | <a href="tel:0987654321">0987654321</a>
            </p>
            <p class="mb-0">
                <span class="fw-bold">Email:</span>
                <a href="mailto:contact@dreamtooth.com">contact@dreamtooth.com</a> | <a href="mailto:support@dreamtooth.vn">support@dreamtooth.vn</a>
            </p>
        </div>

        <%-- NÚT QUAY VỀ TRANG CHỦ --%>
        <div class="text-center mt-4">
            <a href="<c:url value='/home'/>" class="btn btn-primary btn-lg w-100">Quay về Trang chủ</a>
        </div>

        <%-- Đặt biến để ẩn form khi đã gửi thành công --%>
        <c:set var="hideForm" value="true"/>
    </c:if>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger" role="alert">${requestScope.error}</div>
    </c:if>

    <%-- Chỉ hiển thị hướng dẫn và form khi chưa gửi hoặc gửi bị lỗi --%>
    <c:if test="${empty hideForm}">
        <p class="text-center text-muted">Vui lòng nhập **Tên đăng nhập** hoặc **Email** đã đăng ký để chúng tôi gửi liên kết/mã khôi phục.</p>

        <%-- Form này gửi yêu cầu POST đến Servlet /forgot --%>
        <form action="<c:url value='/forgot'/>" method="POST">
            <div class="mb-3">
                <label for="recoveryInput" class="form-label fw-bold">Tên đăng nhập hoặc Email</label>
                    <%-- Giữ lại giá trị input nếu có lỗi --%>
                <input type="text" class="form-control" id="recoveryInput" name="recoveryInput" required placeholder="Nhập tên đăng nhập hoặc email" value="${param.recoveryInput}">
            </div>

            <button type="submit" class="btn btn-warning w-100 mb-3">Gửi Yêu Cầu Khôi Phục</button>
        </form>

        <div class="text-center">
            <a href="<c:url value='/login'/>" class="text-decoration-none">Quay lại Đăng nhập</a>
        </div>
    </c:if>


</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>