<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi Hệ Thống | DreamTooth</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Inter', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            text-align: center;
        }
        .error-container {
            max-width: 600px;
            padding: 40px;
            border-radius: 15px;
            background: white;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .error-icon {
            font-size: 5rem;
            color: #dc3545; /* Màu đỏ */
            margin-bottom: 20px;
            animation: bounce 1s infinite alternate;
        }
        .error-code {
            font-size: 2.5rem;
            font-weight: 700;
            color: #343a40;
            margin-bottom: 10px;
        }
        .error-message {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 30px;
        }
        .btn-home {
            background-color: #007bff;
            color: white;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            transition: background-color 0.3s;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-10px); }
        }
    </style>
</head>
<body>

<div class="error-container">
    <i class="fas fa-exclamation-triangle error-icon"></i>

    <%-- Lấy mã lỗi HTTP (ví dụ: 404, 500) --%>
    <c:set var="statusCode" value="${requestScope['jakarta.servlet.error.status_code']}" />

    <c:choose>
        <c:when test="${statusCode == 404}">
            <h2 class="error-code">404 - KHÔNG TÌM THẤY TRANG</h2>
            <p class="error-message">Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.</p>
        </c:when>
        <c:when test="${statusCode == 403}">
            <h2 class="error-code">403 - KHÔNG CÓ QUYỀN TRUY CẬP</h2>
            <p class="error-message">Bạn không có đủ quyền hạn để truy cập vào tài nguyên này.</p>
        </c:when>
        <c:when test="${statusCode == 500}">
            <h2 class="error-code">500 - LỖI MÁY CHỦ NỘI BỘ</h2>
            <p class="error-message">Hệ thống đang gặp sự cố kỹ thuật. Vui lòng thử lại sau.</p>
        </c:when>
        <c:otherwise>
            <h2 class="error-code">LỖI HỆ THỐNG ${statusCode}</h2>
            <p class="error-message">Đã xảy ra một lỗi không mong muốn trong quá trình xử lý yêu cầu của bạn.</p>
        </c:otherwise>
    </c:choose>

    <%-- Hiển thị thông tin chi tiết (Chỉ nên dùng khi debug) --%>
    <c:if test="${!empty exception}">
        <div class="alert alert-danger small mt-4 text-start">
            <strong>Thông tin kỹ thuật:</strong><br>
            Lỗi: ${exception.getClass().getName()}<br>
            Message: ${exception.getMessage()}
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-home">
        <i class="fas fa-home me-2"></i> Về Trang Chủ
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>