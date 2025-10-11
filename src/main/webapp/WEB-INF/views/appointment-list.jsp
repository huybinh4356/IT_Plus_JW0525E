<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách Lịch Hẹn</title>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }

    .container {
      max-width: 1200px;
      width: 100%;
    }

    .card-form {
      background: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-left: 5px solid #007bff;
      z-index: 10;
      position: relative;
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

    .btn-success {
      background: #007bff;
      border: none;
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
      transition: all 0.3s ease;
    }
    .btn-success:hover {
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

    .btn-primary {
      background-color: #17a2b8;
      border-color: #17a2b8;
      border-radius: 6px;
    }
    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
      border-radius: 6px;
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

    .badge {
      font-size: 0.85rem;
      font-weight: 600;
      padding: 0.5em 0.8em;
      border-radius: 5px;
    }
    .status-pending { background-color: #ffc107 !important; color: #000; }
    .status-confirmed { background-color: #28a745 !important; }
    .status-cancelled { background-color: #dc3545 !important; }
    .status-completed { background-color: #007bff !important; }

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

<div class="container my-5">
  <div class="card-form">
    <h2 class="mb-4">Quản lý Lịch Hẹn</h2>

    <div class="d-flex justify-content-between mb-4">
      <a href="<c:url value='/home'/>" class="btn btn-secondary">
        <i class="fas fa-home me-2"></i> Quay về Trang chủ
      </a>
      <a href="<c:url value='/appointments/new'/>" class="btn btn-success">
        <i class="fas fa-plus me-2"></i> Thêm Lịch Hẹn Mới
      </a>
    </div>

    <c:if test="${not empty sessionScope.message}">
      <div class="alert alert-info alert-dismissible fade show" role="alert">
          ${sessionScope.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <c:remove var="message" scope="session"/>
    </c:if>

    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
        <tr>
          <th>ID</th>
          <th>Mã Hẹn</th>
          <th>Bệnh Nhân</th>
          <th>Dịch Vụ</th>
          <th>Ngày Hẹn</th>
          <th>Giờ Hẹn</th>
          <th>Trạng Thái</th>
          <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="app" items="${listAppointment}">
          <tr>
            <td>${app.appointment_id}</td>
            <td>${app.appointment_code}</td>
            <td>${app.patient_id.full_name}</td>
            <td>${app.service_id.service_name}</td>
            <td>
              <fmt:parseDate value="${app.appointment_date}" pattern="yyyy-MM-dd" var="dateObj" type="date" />
              <fmt:formatDate value="${dateObj}" pattern="dd/MM/yyyy" />
            </td>
            <td>${app.appointment_time}</td>
            <td>
              <c:set var="statusClass" value="${app.status.toLowerCase()}"/>
              <c:choose>
                <c:when test="${statusClass == 'pending'}"><span class="badge status-pending">${app.status}</span></c:when>
                <c:when test="${statusClass == 'confirmed'}"><span class="badge status-confirmed text-white">${app.status}</span></c:when>
                <c:when test="${statusClass == 'cancelled'}"><span class="badge status-cancelled text-white">${app.status}</span></c:when>
                <c:when test="${statusClass == 'completed'}"><span class="badge status-completed text-white">${app.status}</span></c:when>
                <c:otherwise><span class="badge bg-secondary text-white">${app.status}</span></c:otherwise>
              </c:choose>
            </td>
            <td class="text-nowrap">
              <a href="<c:url value='/appointments/detail?id=${app.appointment_id}'/>" class="btn btn-sm btn-info text-white me-1" title="Chi tiết"><i class="fas fa-eye"></i></a>
              <a href="<c:url value='/appointments/edit?id=${app.appointment_id}'/>" class="btn btn-sm btn-primary me-1" title="Sửa"><i class="fas fa-edit"></i></a>
              <a href="<c:url value='/appointments/delete?id=${app.appointment_id}'/>" class="btn btn-sm btn-danger" title="Xóa"
                 onclick="return confirm('Bạn chắc chắn muốn xóa lịch hẹn ${app.appointment_code}?')"><i class="fas fa-trash-alt"></i></a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
    <c:if test="${empty listAppointment}">
      <p class="text-center text-muted mt-4">Không có lịch hẹn nào được tìm thấy.</p>
    </c:if>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>