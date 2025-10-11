<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chi tiết Lịch Hẹn</title>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_3.png');
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
      border-left: 5px solid #007bff;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
      width: 100%;
      max-width: 800px;
    }
    .card-form:hover {
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

    .dl-row dt {
      font-weight: 600;
      color: #6c757d;
      margin-bottom: 10px;
    }
    .dl-row dd {
      margin-bottom: 10px;
      font-weight: 500;
      color: #343a40;
    }

    .btn-primary {
      background: #007bff;
      border: none;
      border-radius: 8px;
      padding: 10px 25px;
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

    .badge {
      font-size: 0.9rem;
      font-weight: 600;
      padding: 0.5em 0.8em;
      border-radius: 5px;
    }
    /* Thêm các class badge để khớp với ENUM trong Java */
    .status-PENDING { background-color: #ffc107 !important; color: #000; }
    .status-CONFIRMED { background-color: #28a745 !important; color: #fff; }
    .status-CANCELLED { background-color: #dc3545 !important; color: #fff; }
    .status-COMPLETED { background-color: #007bff !important; color: #fff; }


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

<div class="container my-5 d-flex justify-content-center align-items-center" style="min-height: 80vh;">
  <div class="card-form col-md-8 mx-auto">
    <c:if test="${appointment != null}">
      <h2 class="mb-4">Chi tiết Lịch Hẹn #${appointment.appointment_id}</h2>
      <hr class="my-4">

      <dl class="row dl-row">
        <dt class="col-sm-4">Mã Hẹn:</dt>
        <dd class="col-sm-8">${appointment.appointment_code}</dd>

        <dt class="col-sm-4">Bệnh Nhân:</dt>
        <dd class="col-sm-8">${appointment.patient_id.full_name} (ID: ${appointment.patient_id.user_id})</dd>

        <dt class="col-sm-4">Dịch Vụ:</dt>
        <dd class="col-sm-8">${appointment.service_id.service_name} (ID: ${appointment.service_id.service_id})</dd>

        <dt class="col-sm-4">Ngày Hẹn:</dt>
        <dd class="col-sm-8">${appointment.appointment_date}</dd>

        <dt class="col-sm-4">Giờ Hẹn:</dt>
        <dd class="col-sm-8">${appointment.appointment_time}</dd>

        <dt class="col-sm-4">Trạng Thái:</dt>
        <dd class="col-sm-8">
          <c:set var="statusClass" value="status-${appointment.status}" />
          <span class="badge ${statusClass}">${appointment.status}</span>
        </dd>

        <dt class="col-sm-4">Ghi Chú:</dt>
        <dd class="col-sm-8">${appointment.note}</dd>
      </dl>

      <hr class="my-4">
      <div class="d-flex justify-content-start gap-2">
        <a href="<c:url value='/appointments/edit?id=${appointment.appointment_id}'/>" class="btn btn-primary">
          <i class="fas fa-edit me-1"></i> Sửa thông tin
        </a>
        <a href="<c:url value='/appointments'/>" class="btn btn-secondary">
          <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
        </a>
      </div>
    </c:if>
    <c:if test="${appointment == null}">
      <h2 class="text-danger">Lỗi</h2>
      <p class="alert alert-danger">Không tìm thấy lịch hẹn này.</p>
      <a href="<c:url value='/appointments'/>" class="btn btn-primary">
        <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
      </a>
    </c:if>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>