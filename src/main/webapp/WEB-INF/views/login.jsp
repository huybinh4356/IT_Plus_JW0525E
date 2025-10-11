<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập Hệ thống DreamTooth</title>
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
      align-items: center;
      justify-content: center;
      overflow: hidden;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_2.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .login-container {
      background: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
      border-left: 5px solid #007bff;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
      width: 100%;
      max-width: 450px;
    }
    .login-container:hover {
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    }

    h2 {
      color: #007bff;
      font-weight: 700;
      margin-bottom: 25px;
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

    .form-control {
      border-radius: 8px;
      padding: 10px 15px;
      border: 1px solid #ced4da;
      background-color: rgba(255, 255, 255, 0.9);
      transition: all 0.3s ease;
    }
    .form-control:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
      background-color: #fff;
    }

    .btn-primary {
      background: #007bff;
      border: none;
      border-radius: 8px;
      padding: 12px 25px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
      transition: all 0.3s ease;
    }
    .btn-primary:hover {
      background: #0056b3;
      box-shadow: 0 6px 15px rgba(0, 123, 255, 0.4);
      transform: translateY(-1px);
    }

    .link-separator {
      margin: 0 8px;
      color: #adb5bd;
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

<div class="login-container">
  <h2 class="text-center">Đăng nhập DreamTooth</h2>

  <c:if test="${not empty requestScope.error}">
    <div class="alert alert-danger" role="alert">
      <i class="fas fa-exclamation-circle me-2"></i> ${requestScope.error}
    </div>
  </c:if>

  <form action="<c:url value='/login'/>" method="POST">
    <div class="mb-3">
      <label for="username" class="form-label fw-bold">Tên đăng nhập</label>
      <div class="input-group">
        <span class="input-group-text bg-light"><i class="fas fa-user text-primary"></i></span>
        <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
      </div>
    </div>
    <div class="mb-4">
      <label for="password" class="form-label fw-bold">Mật khẩu</label>
      <div class="input-group">
        <span class="input-group-text bg-light"><i class="fas fa-lock text-primary"></i></span>
        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
      </div>
    </div>
    <button type="submit" class="btn btn-primary w-100 mb-3">
      <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập
    </button>
  </form>

  <div class="mt-3 text-center small">
    <a href="<c:url value='/forgot'/>" class="text-decoration-none">
      <i class="fas fa-question-circle me-1"></i> Quên mật khẩu?
    </a>

    <span class="link-separator">|</span>

    <a href="<c:url value='/guidance'/>" class="text-decoration-none">
      <i class="fas fa-info-circle me-1"></i> Hướng dẫn tài khoản
    </a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>