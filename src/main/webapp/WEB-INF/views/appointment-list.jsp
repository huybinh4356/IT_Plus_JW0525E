<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh Sách Lịch Hẹn</title>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }

    .content-card {
      background: #ffffff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-left: 5px solid #007bff;
      z-index: 10;
      position: relative;
      height: 100%;
    }

    h1 {
      color: #007bff;
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
      background-color: #007bff;
      border-radius: 2px;
    }

    h2 {
      color: #007bff;
      font-weight: 700;
      margin-bottom: 25px;
      position: relative;
      font-size: 1.75rem;
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
      transition: all 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
    }

    .btn-primary, .btn-success {
      border: none;
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 600;
      transition: all 0.3s ease;
    }
    .btn-primary {
      background: #007bff;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
    }
    .btn-primary:hover {
      background: #0056b3;
      transform: translateY(-1px);
    }
    .btn-info, .btn-warning, .btn-danger {
      border-radius: 6px;
      font-weight: 500;
    }

    .appointment-card {
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      margin-bottom: 1rem;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      transition: all 0.3s ease;
      overflow: hidden;
    }
    .appointment-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    .card-header-status {
      padding: 10px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #eee;
    }

    .status-badge {
      font-size: 0.9rem;
      font-weight: 600;
      padding: 0.5em 0.8em;
      border-radius: 5px;
    }
    .status-pending { background-color: #ffc107 !important; color: #000; }
    .status-confirmed { background-color: #28a745 !important; color: white; }
    .status-cancelled { background-color: #dc3545 !important; color: white; }
    .status-completed { background-color: #007bff !important; color: white; }
    .status-other { background-color: #6c757d !important; color: white; }

    .appointment-card .card-body {
      padding: 20px;
    }

    .appointment-card .card-title {
      color: #007bff;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .appointment-card .card-info-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
      font-size: 0.95rem;
    }
    .card-info-grid .info-item {
      display: flex;
      align-items: flex-start;
    }
    .card-info-grid .info-item i {
      margin-right: 8px;
      color: #007bff;
      width: 16px;
      text-align: center;
      padding-top: 3px;
    }

    .appointment-card .card-footer {
      background-color: #f8f9fa;
      text-align: right;
      padding: 15px 20px;
    }

    .background-shape-1, .background-shape-2 {
      position: fixed;
      border-radius: 50%;
      z-index: -1;
      opacity: 0.5;
      filter: blur(100px);
      animation: floatShape 10s ease-in-out infinite alternate;
    }
    .background-shape-1 {
      top: -100px; left: -100px; width: 400px; height: 400px;
      background: radial-gradient(circle, rgba(173, 216, 230, 0.3), rgba(173, 216, 230, 0));
    }
    .background-shape-2 {
      bottom: -150px; right: -150px; width: 500px; height: 500px;
      background: radial-gradient(circle, rgba(135, 206, 235, 0.25), rgba(135, 206, 235, 0));
      animation-direction: alternate-reverse;
    }
    @keyframes floatShape {
      from { transform: translate(0, 0); }
      to { transform: translate(20px, 20px); }
    }
  </style>
</head>
<body>
<div class="background-shape-1"></div>
<div class="background-shape-2"></div>

<div class="container-xl my-5">

  <h1>Quản lý Lịch Hẹn</h1>

  <div class="mb-3">
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
      <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
    </a>
  </div>

  <div class="row g-4">
    <div class="col-lg-10 mx-auto">
      <div class="content-card">

        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0 text-start">
            <i class="fas fa-calendar-check me-2"></i> Danh Sách Lịch Hẹn
          </h2>
          <a href="<c:url value='/appointments/new'/>" class="btn btn-primary btn-sm">
            <i class="fas fa-plus me-2"></i> Thêm Lịch Mới
          </a>
        </div>

        <c:if test="${not empty sessionScope.message}">
          <div class="alert alert-info alert-dismissible fade show" role="alert">
              ${sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          <c:remove var="message" scope="session"/>
        </c:if>

        <c:choose>
          <c:when test="${empty listAppointment}">
            <div class="alert alert-warning" role="alert">
              <i class="fas fa-exclamation-triangle me-2"></i> Không có lịch hẹn nào được tìm thấy.
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="app" items="${listAppointment}">
              <div class="appointment-card shadow-sm">
                <div class="card-header-status">
                  <span class="fw-bold text-dark">Mã hẹn: ${app.appointment_code}</span>

                  <c:set var="statusClass" value="${app.status.toLowerCase()}"/>
                  <c:choose>
                    <c:when test="${statusClass == 'pending'}"><span class="status-badge status-pending">${app.status}</span></c:when>
                    <c:when test="${statusClass == 'confirmed'}"><span class="status-badge status-confirmed">${app.status}</span></c:when>
                    <c:when test="${statusClass == 'cancelled'}"><span class="status-badge status-cancelled">${app.status}</span></c:when>
                    <c:when test="${statusClass == 'completed'}"><span class="status-badge status-completed">${app.status}</span></c:when>
                    <c:otherwise><span class="status-badge status-other">${app.status}</span></c:otherwise>
                  </c:choose>
                </div>
                <div class="card-body">
                  <h5 class="card-title">${app.service_id.service_name}</h5>

                  <div class="card-info-grid">
                    <div class="info-item">
                      <i class="fas fa-user-injured fa-fw"></i>
                      <span>${app.patient_id.full_name}</span>
                    </div>
                    <div class="info-item">
                      <i class="fas fa-user-md fa-fw"></i>
                      <span>${app.doctor_id.name}</span>
                    </div>
                    <div class="info-item">
                      <i class="fas fa-calendar-day fa-fw"></i>
                      <span>
                                                <fmt:parseDate value="${app.appointment_date}" pattern="yyyy-MM-dd" var="dateObj" type="date" />
                                                <fmt:formatDate value="${dateObj}" pattern="dd/MM/yyyy" />
                                            </span>
                    </div>
                    <div class="info-item">
                      <i class="fas fa-clock fa-fw"></i>
                      <span>${app.appointment_time}</span>
                    </div>
                  </div>
                </div>
                <div class="card-footer">
                  <button type="button" class="btn btn-info btn-sm me-1 text-white"
                          data-bs-toggle="modal" data-bs-target="#detailModal${app.appointment_id}">
                    <i class="fas fa-eye"></i> Xem
                  </button>

                  <a href="<c:url value='/appointments/edit?id=${app.appointment_id}'/>" class="btn btn-sm btn-warning me-1" title="Sửa"><i class="fas fa-edit"></i> Sửa</a>

                  <a href="<c:url value='/appointments/delete?id=${app.appointment_id}'/>" class="btn btn-sm btn-danger" title="Xóa"
                     onclick="return confirm('Bạn chắc chắn muốn xóa lịch hẹn ${app.appointment_code}?')"><i class="fas fa-trash-alt"></i> Xóa</a>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>

      </div>
    </div>
  </div>
</div>

<c:forEach var="app" items="${listAppointment}">
  <div class="modal fade" id="detailModal${app.appointment_id}" tabindex="-1"
       aria-labelledby="detailModalLabel${app.appointment_id}" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="detailModalLabel${app.appointment_id}">Chi Tiết Lịch Hẹn: ${app.appointment_code}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <dl class="row">
            <dt class="col-sm-4 text-muted">Mã ID:</dt>
            <dd class="col-sm-8">${app.appointment_id}</dd>

            <dt class="col-sm-4 text-muted">Bệnh nhân:</dt>
            <dd class="col-sm-8">${app.patient_id.full_name}</dd>

            <dt class="col-sm-4 text-muted">Bác sĩ phụ trách:</dt>
            <dd class="col-sm-8">${app.doctor_id.name}</dd>

            <dt class="col-sm-4 text-muted">Dịch vụ:</dt>
            <dd class="col-sm-8">${app.service_id.service_name}</dd>

            <dt class="col-sm-4 text-muted">Ngày hẹn:</dt>
            <dd class="col-sm-8">
              <fmt:parseDate value="${app.appointment_date}" pattern="yyyy-MM-dd" var="dateObj" type="date" />
              <fmt:formatDate value="${dateObj}" pattern="dd/MM/yyyy" />
            </dd>

            <dt class="col-sm-4 text-muted">Giờ hẹn:</dt>
            <dd class="col-sm-8">${app.appointment_time}</dd>

            <dt class="col-sm-4 text-muted">Trạng thái:</dt>
            <dd class="col-sm-8">
              <c:set var="statusClass" value="${app.status.toLowerCase()}"/>
              <c:choose>
                <c:when test="${statusClass == 'pending'}"><span class="status-badge status-pending">${app.status}</span></c:when>
                <c:when test="${statusClass == 'confirmed'}"><span class="status-badge status-confirmed">${app.status}</span></c:when>
                <c:when test="${statusClass == 'cancelled'}"><span class="status-badge status-cancelled">${app.status}</span></c:when>
                <c:when test="${statusClass == 'completed'}"><span class="status-badge status-completed">${app.status}</span></c:when>
                <c:otherwise><span class="status-badge status-other">${app.status}</span></c:otherwise>
              </c:choose>
            </dd>

            <dt class="col-sm-4 text-muted">Ghi chú của bệnh nhân:</dt>
            <dd class="col-sm-8"><p class="border p-2 rounded bg-light">${not empty app.notes ? app.notes : "Không có ghi chú."}</p></dd>
          </dl>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="fas fa-times"></i> Đóng
          </button>
        </div>
      </div>
    </div>
  </div>
</c:forEach>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>