<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký lịch trực tiếp</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background-color: #f0f8ff;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 50px 0;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        .form-container {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #007bff;
            transition: box-shadow 0.3s ease;
            z-index: 10;
            position: relative;
            width: 100%;
            max-width: 650px;
        }
        .form-container:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #007bff;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        h2::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 3px;
            background-color: #007bff;
            border-radius: 2px;
        }

        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            background-color: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
            background-color: #fff;
        }

        .btn-success {
            background: #28a745;
            border: none;
            border-radius: 8px;
            padding: 10px 25px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: #1e7e34;
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
            transform: translateY(-1px);
        }

        .btn-secondary {
            border-radius: 8px;
            padding: 10px 25px;
            font-weight: 500;
            color: #495057;
            background-color: #e9ecef;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #dee2e6;
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

<div class="form-container">
    <h2>Đăng ký lịch trực tiếp</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form method="post" action="guest-requests">
        <input type="hidden" name="action" value="add"/>

        <input type="hidden" name="userRoleId" value="${sessionScope.userRoleId}"/>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-user me-2 text-primary"></i> Họ tên</label>
            <input type="text" name="fullName" class="form-control" placeholder="Nguyễn Văn A" value="${requestObj.fullName}" required/>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-phone me-2 text-primary"></i> Điện thoại</label>
            <input type="text" name="phone" class="form-control" placeholder="09xxxxxxxx" value="${requestObj.phone}" required/>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-envelope me-2 text-primary"></i> Email</label>
            <input type="email" name="email" class="form-control" placeholder="vidu@email.com" value="${requestObj.email}"/>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-id-card me-2 text-primary"></i> CCCD</label>
            <input type="text" name="cccd" class="form-control" placeholder="0011xxxxxxxx" value="${requestObj.cccd}"/>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-map-marker-alt me-2 text-primary"></i> Địa chỉ</label>
            <input type="text" name="address" class="form-control" placeholder="Số nhà, đường, quận/huyện" value="${requestObj.address}"/>
        </div>
        <div class="mb-4">
            <label class="form-label"><i class="fas fa-comment-dots me-2 text-primary"></i> Lời nhắn</label>
            <textarea name="message" class="form-control" rows="3" placeholder="Mô tả sơ qua về vấn đề răng miệng của bạn...">${requestObj.message}</textarea>
        </div>
        <div class="d-flex justify-content-between gap-2">
            <button type="submit" class="btn btn-success w-50">
                <i class="fas fa-paper-plane me-2"></i> Gửi Yêu cầu
            </button>
            <a href="<c:url value='/guest-requests'/>" class="btn btn-secondary w-50">
                <i class="fas fa-times me-2"></i> Hủy
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>