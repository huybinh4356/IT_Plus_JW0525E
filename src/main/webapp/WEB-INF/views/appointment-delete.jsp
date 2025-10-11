<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Xác nhận Xóa</title>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .card-form {
      background: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-left: 5px solid #dc3545; /* Đổi viền sang màu đỏ nguy hiểm */
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
      width: 100%;
      max-width: 500px;
    }
    .card-form:hover {
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    h2 {
      color: #dc3545; /* Màu đỏ cho tiêu đề xóa */
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
      background-color: #dc3545; /* Đường gạch dưới màu đỏ */
      border-radius: 2px;
    }

    .alert-warning {
      border-left: 5px solid #ffc107;
      background-color: #fffde7;
      font-weight: 500;
    }

    .btn-danger {
      background: #dc3545;
      border: none;
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
      transition: all 0.3s ease;
    }
    .btn-danger:hover {
      background: #c82333;
      box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
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

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="card-form col-md-6">
    <h2>Xác nhận Xóa Lịch Hẹn</h2>

    <c:if test="${appointment != null}">
      <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle me-1"></i> Bạn có chắc chắn muốn xóa lịch hẹn sau không? **Thao tác này không thể hoàn tác.**
      </div>

      <dl class="row mb-4">
        <dt class="col-sm-4 text-muted">ID:</dt>
        <dd class="col-sm-8 text-dark">${appointment.appointment_id}</dd>

        <dt class="col-sm-4 text-muted">Mã Hẹn:</dt>
        <dd class="col-sm-8 text-dark font-weight-bold">${appointment.appointment_code}</dd>

        <dt class="col-sm-4 text-muted">Ngày/Giờ:</dt>
        <dd class="col-sm-8 text-dark">${appointment.appointment_date} lúc ${appointment.appointment_time}</dd>

        <dt class="col-sm-4 text-muted">Bệnh Nhân:</dt>
        <dd class="col-sm-8 text-dark">${appointment.patient_id.full_name}</dd>

      </dl>

      <form method="post" action="<c:url value='/appointments/delete'/>" class="d-flex justify-content-between mt-4">
        <input type="hidden" name="id" value="${appointment.appointment_id}" />
        <button type="submit" class="btn btn-danger w-50 me-2">
          <i class="fas fa-trash-alt me-1"></i> XÁC NHẬN XÓA
        </button>
        <a href="<c:url value='/appointments'/>" class="btn btn-secondary w-50">
          <i class="fas fa-times-circle me-1"></i> HỦY
        </a>
      </form>
    </c:if>
    <c:if test="${appointment == null}">
      <div class="alert alert-danger">
        <p>Không tìm thấy lịch hẹn để xóa.</p>
      </div>
      <p class="text-center">
        <a href="<c:url value='/appointments'/>" class="btn btn-primary">
          <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
        </a>
      </p>
    </c:if>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>