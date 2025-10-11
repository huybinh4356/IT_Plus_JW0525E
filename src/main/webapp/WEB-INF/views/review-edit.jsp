<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chỉnh sửa đánh giá</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Cập nhật về Bootstrap 4.5.2 để đồng nhất với các tệp JSP khác -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

  <style>
    /* Lưu ý: Các lớp .container trong Bootstrap 4 và 5 hơi khác nhau về max-width */
    body {
      background-color: #f0f8ff;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      color: #333;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      overflow: hidden;
      padding-top: 50px;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .container {
      max-width: 700px; /* Định nghĩa lại max-width cho container */
    }

    .card {
      background: #ffffff;
      padding: 0;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
      border: none;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
    }
    .card:hover {
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    }

    .card-header {
      /* Dùng bg-warning từ Bootstrap 4 */
      background-color: #ffc107 !important; /* Màu vàng (Warning) cho header */
      border-bottom: none;
      border-radius: 12px 12px 0 0;
      padding: 20px 30px;
    }

    h3 {
      font-weight: 700;
      margin-bottom: 0;
      color: #333;
    }

    label {
      font-weight: 600;
      color: #495057;
      margin-bottom: 5px;
      display: block;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
      border: 1px solid #ced4da;
      background-color: rgba(255, 255, 255, 0.9);
      transition: all 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
      background-color: #fff;
    }
    textarea.form-control {
      min-height: 100px;
      resize: vertical;
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

    .btn-secondary {
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 500;
      color: #495057;
      background-color: #e9ecef;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
    }
    .btn-secondary:hover {
      background-color: #dee2e6;
    }

    /* Background Shapes */
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

<!-- Đã đổi py-4 thành mt-4 mb-4 vì Bootstrap 4 không có py-4 -->
<div class="container mt-4 mb-4">
<a href="reviews" class="btn btn-secondary mb-4 shadow-sm">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <i class="fas fa-arrow-left mr-2"></i> Trở về danh sách
</a>

<div class="card shadow">
<!-- Đã sửa text-dark thành text-secondary vì màu sắc hợp hơn cho nền vàng -->
<div class="card-header bg-warning text-secondary">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <!-- ĐÃ THÊM KHOẢNG TRẮNG SAU KÝ TỰ '#' ĐỂ KHẮC PHỤC LỖI PARSER JSP/EL -->
  <h3 class="mb-0"><i class="fas fa-edit mr-2"></i> Chỉnh sửa đánh giá # ${review.id}</h3>
</div>
<div class="card-body">
<c:if test="${not empty error}">
  <div class="alert alert-danger" role="alert">
    <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
    <i class="fas fa-exclamation-triangle mr-2"></i> ${error}
  </div>
</c:if>

<form action="reviews" method="post">
<input type="hidden" name="action" value="update">
<input type="hidden" name="id" value="${review.id}">

<p class="mb-4 text-muted">ID Đánh giá: <strong>${review.id}</strong></p>

<div class="form-group mb-3"> <!-- Dùng form-group và mb-3 cho Bootstrap 4 -->
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <label class="form-label"><i class="fas fa-user mr-2 text-primary"></i> ID Bệnh nhân</label>
  <input type="number" class="form-control" name="patient_id" value="${review.patientId}" required readonly>
</div>

<div class="form-group mb-3">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <label class="form-label"><i class="fas fa-briefcase mr-2 text-primary"></i> ID Dịch vụ</label>
  <input type="number" class="form-control" name="service_id" value="${review.serviceId}" placeholder="ID dịch vụ (tùy chọn)">
</div>

<div class="form-group mb-3">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <label class="form-label"><i class="fas fa-calendar-check mr-2 text-primary"></i> ID Lịch hẹn</label>
  <input type="number" class="form-control" name="appointment_id" value="${review.appointmentId}" placeholder="ID lịch hẹn (tùy chọn)">
</div>

<div class="form-group mb-4">
<!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
<label class="form-label"><i class="fas fa-medal mr-2 text-primary"></i> Rating (1-5 sao)</label>
<select name="rating" class="form-control" required> <!-- Dùng form-control thay vì form-select trong BS4 -->
  <option value="5"<c:if test="${review.rating == 5}"> selected</c:if>>★★★★★ 5 Sao (Tuyệt vời)</option>
  <option value="4"<c:if test="${review.rating == 4}"> selected</c:if>>★★★★☆ 4 Sao (Tốt)</option>
  <option value="3"<c:if test="${review.rating == 3}"> selected</c:if>>★★★☆☆ 3 Sao (Trung bình)</option>
  <option value="2"<c:if test="${review.rating == 2}"> selected</c:if>>★★☆☆☆ 2 Sao (Kém)</option>
  <option value="1"<c:if test="${review.rating == 1}"> selected</c:if>>★☆☆☆☆ 1 Sao (Rất kém)</option>
  </select>
  </div>

  <div class="form-group mb-4">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <label class="form-label"><i class="fas fa-comments mr-2 text-primary"></i> Bình luận</label>
  <textarea name="comment" class="form-control" rows="4" placeholder="Chỉnh sửa bình luận của bạn...">${review.comment}</textarea>
  </div>

  <button type="submit" class="btn btn-primary w-100">
  <!-- Đã sửa me-2 thành mr-2 cho Bootstrap 4 -->
  <i class="fas fa-sync-alt mr-2"></i> Cập nhật đánh giá
  </button>
  </form>
  </div>
  </div>
  </div>
  <!-- Loại bỏ Bootstrap 5 JS, không cần thiết cho form này và giữ cho môi trường sạch sẽ hơn -->
  </body>
  </html>
