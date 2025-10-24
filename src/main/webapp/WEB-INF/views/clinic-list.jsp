<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Thông Tin Phòng Khám</title>
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
      padding-top: 50px;
      padding-bottom: 50px;
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

    .btn-info, .btn-warning, .btn-danger {
      border-radius: 6px;
      font-weight: 500;
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

    .table-logo {
      width: 50px;
      height: 50px;
      object-fit: cover;
      border-radius: 5px;
      border: 1px solid #eee;
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

    .modal-title {
      color: #007bff;
      font-weight: 600;
    }
  </style>
</head>
<body>
<div class="background-shape-1"></div>
<div class="background-shape-2"></div>

<div class="container mt-4">
  <div class="card-form">
    <h1>Quản Lý Thông Tin Phòng Khám</h1>

    <%-- Nút Quay lại Trang chủ (Luôn hiển thị) --%>
    <div class="mb-4">
      <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
        <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
      </a>
    </div>

    <%-- KHỐI NÚT CHỈ DÀNH CHO ADMIN (role_id = 1) --%>
    <c:if test="${sessionScope.userRoleId == 1}">
      <div class="d-flex justify-content-end mb-4">
        <a href="clinic-info?action=new" class="btn btn-success">
          <i class="fas fa-plus me-2"></i> Thêm Phòng Khám Mới
        </a>
      </div>
    </c:if>
    <%-- KẾT THÚC KHỐI NÚT ADMIN --%>

    <c:choose>
      <c:when test="${empty clinicList}">
        <div class="alert alert-warning" role="alert">
          <i class="fas fa-exclamation-triangle me-2"></i> Hiện chưa có thông tin phòng khám nào.
        </div>
      </c:when>

      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle">
            <thead style="background-color: #007bff; color: white;">
            <tr>
              <th>ID</th>
              <th>Logo</th>
              <th>Tên Phòng Khám</th>
              <th>Hotline</th>
              <th>Email</th>
              <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="clinic" items="${clinicList}">
              <tr>
                <td><c:out value="${clinic.clinic_id}"/></td>
                <td>
                  <img src="<c:out value="${clinic.logo}"/>"
                       alt="Logo"
                       class="table-logo">
                </td>
                <td><c:out value="${clinic.name}"/></td>
                <td><c:out value="${clinic.hostline}"/></td>
                <td><c:out value="${clinic.email}"/></td>
                <td class="text-nowrap">
                    <%-- Nút Xem Chi Tiết --%>
                  <button type="button" class="btn btn-info btn-sm me-1 text-white"
                          data-bs-toggle="modal" data-bs-target="#detailModal${clinic.clinic_id}">
                    <i class="fas fa-eye"></i> Xem
                  </button>

                    <%-- Nút Sửa và Xóa (Chỉ hiển thị cho Admin) --%>
                  <c:if test="${sessionScope.userRoleId == 1}">
                    <a href="clinic-info?action=edit&id=${clinic.clinic_id}"
                       class="btn btn-warning btn-sm me-1">
                      <i class="fas fa-edit"></i> Sửa
                    </a>

                    <a href="clinic-info?action=delete&id=${clinic.clinic_id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa ${clinic.name} (ID: ${clinic.clinic_id})?');">
                      <i class="fas fa-trash-alt"></i> Xóa
                    </a>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<%-- ---------------------------------------------------------------- --%>
<%-- MODAL DEFINITIONS (ĐẶT NGOÀI VÒNG LẶP VÀ NGOÀI TABLE) --%>
<%-- ---------------------------------------------------------------- --%>
<c:forEach var="clinic" items="${clinicList}">
  <div class="modal fade" id="detailModal${clinic.clinic_id}" tabindex="-1"
       aria-labelledby="detailModalLabel${clinic.clinic_id}" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
            <%-- Tiêu đề Modal với ID DUY NHẤT --%>
          <h5 class="modal-title" id="detailModalLabel${clinic.clinic_id}">Chi Tiết Phòng Khám: ${clinic.name}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <dl class="row">
            <dt class="col-sm-4 text-muted">Mã ID:</dt>
            <dd class="col-sm-8">${clinic.clinic_id}</dd>

            <dt class="col-sm-4 text-muted">Địa Chỉ:</dt>
            <dd class="col-sm-8">${clinic.address}</dd>

            <dt class="col-sm-4 text-muted">Hotline:</dt>
            <dd class="col-sm-8">${clinic.hostline}</dd>

            <dt class="col-sm-4 text-muted">Email:</dt>
            <dd class="col-sm-8">${clinic.email}</dd>

            <dt class="col-sm-4 text-muted">Giờ Làm Việc:</dt>
            <dd class="col-sm-8">${clinic.working_hours}</dd>

            <dt class="col-sm-4 text-muted">Mô Tả:</dt>
            <dd class="col-sm-8"><p class="border p-2 rounded bg-light">${clinic.description}</p></dd>
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