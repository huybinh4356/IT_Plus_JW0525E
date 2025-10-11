<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chi tiết Người dùng #${user.user_id}</title>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .card-form {
      background: #ffffff;
      padding: 0;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
      border: none;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
      max-width: 800px;
      width: 100%;
    }

    .card-header {
      background-color: #007bff !important;
      border-bottom: none;
      border-radius: 12px 12px 0 0;
      padding: 20px 30px;
    }

    h3 {
      font-weight: 700;
      margin-bottom: 0;
    }

    .card-body {
      padding: 30px;
    }

    .detail-row dt {
      font-weight: 600;
      color: #495057;
      margin-bottom: 15px;
      width: 150px; /* Chiều rộng cố định cho tiêu đề */
    }
    .detail-row dd {
      margin-bottom: 15px;
      font-weight: 500;
      color: #343a40;
    }
    .detail-row {
      display: flex;
      flex-wrap: wrap;
      margin-bottom: 0;
    }
    .detail-row > * {
      margin-right: 20px;
    }

    .section-title {
      border-bottom: 2px solid #e9ecef;
      padding-bottom: 5px;
      margin-top: 20px;
      margin-bottom: 15px;
      color: #007bff;
      font-weight: 600;
    }

    .btn-custom {
      background-color: #007bff;
      border: none;
      color: #fff;
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
      transition: all 0.3s ease;
    }
    .btn-custom:hover {
      background-color: #0056b3;
      box-shadow: 0 6px 12px rgba(0, 123, 255, 0.3);
    }

    .btn-secondary-custom {
      background-color: #6c757d;
      border: none;
      color: #fff;
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      box-shadow: 0 4px 8px rgba(108, 117, 125, 0.2);
      transition: all 0.3s ease;
    }
    .btn-secondary-custom:hover {
      background-color: #5a6268;
      box-shadow: 0 6px 12px rgba(108, 117, 125, 0.3);
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

<div class="container mt-5">
  <div class="card-form shadow">
    <div class="card-header">
      <h3 class="text-white"><i class="fas fa-id-card me-2"></i> Chi tiết Người dùng #${user.user_id}</h3>
    </div>
    <div class="card-body">

      <h5 class="section-title"><i class="fas fa-user-circle me-2"></i> Thông tin cá nhân</h5>
      <dl class="detail-row row">
        <dt class="col-sm-3">ID:</dt>
        <dd class="col-sm-9 fw-bold">${user.user_id}</dd>

        <dt class="col-sm-3">Tên đăng nhập:</dt>
        <dd class="col-sm-9">${user.username}</dd>

        <dt class="col-sm-3">Họ tên:</dt>
        <dd class="col-sm-9 fw-bold text-primary">${user.full_name}</dd>

        <dt class="col-sm-3">Ngày sinh:</dt>
        <dd class="col-sm-9">${user.formattedDob}</dd>

        <dt class="col-sm-3">Giới tính:</dt>
        <dd class="col-sm-9">${user.gender}</dd>

        <dt class="col-sm-3">CCCD:</dt>
        <dd class="col-sm-9">${user.cccd}</dd>
      </dl>

      <h5 class="section-title"><i class="fas fa-address-book me-2"></i> Liên hệ & Địa chỉ</h5>
      <dl class="detail-row row">
        <dt class="col-sm-3">SĐT:</dt>
        <dd class="col-sm-9">${user.phone}</dd>

        <dt class="col-sm-3">Email:</dt>
        <dd class="col-sm-9">${user.email}</dd>

        <dt class="col-sm-3">Địa chỉ:</dt>
        <dd class="col-sm-9">${user.address}</dd>
      </dl>

      <h5 class="section-title"><i class="fas fa-briefcase me-2"></i> Vai trò & Trạng thái</h5>
      <dl class="detail-row row">
        <dt class="col-sm-3">Vai trò:</dt>
        <dd class="col-sm-9">
          <c:choose>
            <c:when test="${user.role_id == 1}"><span class="badge bg-danger"><i class="fas fa-user-tie"></i> Quản trị</span></c:when>
            <c:when test="${user.role_id == 2}"><span class="badge bg-info"><i class="fas fa-user-md"></i> Bác sĩ</span></c:when>
            <c:when test="${user.role_id == 3}"><span class="badge bg-success"><i class="fas fa-hospital-user"></i> Bệnh nhân</span></c:when>
            <c:otherwise><span class="badge bg-secondary">Không xác định</span></c:otherwise>
          </c:choose>
        </dd>

        <dt class="col-sm-3">Chuyên ngành:</dt>
        <dd class="col-sm-9">
          <c:choose>
            <c:when test="${not empty user.specialty and not empty user.specialty.name}">
              <span class="text-info fw-bold">${user.specialty.name}</span>
            </c:when>
            <c:otherwise>—</c:otherwise>
          </c:choose>
        </dd>

        <dt class="col-sm-3">Bằng cấp:</dt>
        <dd class="col-sm-9">${user.degree}</dd>

        <dt class="col-sm-3">Vị trí:</dt>
        <dd class="col-sm-9">${user.position}</dd>

        <dt class="col-sm-3">Trạng thái:</dt>
        <dd class="col-sm-9">
          <c:choose>
            <c:when test="${user.is_active}">
              <span class="badge bg-success"><i class="fas fa-check-circle"></i> Đang hoạt động</span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-danger"><i class="fas fa-times-circle"></i> Ngừng hoạt động</span>
            </c:otherwise>
          </c:choose>
        </dd>

        <dt class="col-sm-3">Ngày tạo:</dt>
        <dd class="col-sm-9">
          <c:choose>
            <c:when test="${not empty user.formattedCreatedAt}">
              ${user.formattedCreatedAt}
            </c:when>
            <c:otherwise>—</c:otherwise>
          </c:choose>
        </dd>
      </dl>

     <div class="text-center mt-4 pt-3 border-top d-flex justify-content-center gap-3">
<%--        <a href="${pageContext.request.contextPath}/users?action=editForm&id=${user.user_id}" class="btn btn-secondary-custom">--%>
<%--          <i class="fas fa-edit me-2"></i> Chỉnh sửa--%>
<%--        </a>--%>

        <a href="${pageContext.request.contextPath}/users" class="btn btn-custom">
          <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
        </a>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>