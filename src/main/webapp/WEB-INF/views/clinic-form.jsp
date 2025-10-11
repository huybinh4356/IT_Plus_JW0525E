<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><c:choose><c:when test="${clinic != null}">Chỉnh Sửa</c:when><c:otherwise>Thêm Mới</c:otherwise></c:choose> Phòng Khám</title>
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
      padding: 50px 0;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
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

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
      border: 1px solid #ced4da;
      background-color: rgba(255, 255, 255, 0.8);
      transition: all 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
      background-color: #fff;
    }
    .form-text {
      font-size: 0.85rem;
      font-style: italic;
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
  <div class="card-form col-lg-8 col-md-10 mx-auto">
    <h1 class="mb-4">
      <c:choose>
        <c:when test="${clinic != null}">Chỉnh Sửa Phòng Khám: ${clinic.name}</c:when>
        <c:otherwise>Thêm Phòng Khám Mới</c:otherwise>
      </c:choose>
    </h1>

    <form method="POST" action="clinic-info">

      <c:if test="${clinic != null}">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="${clinic.clinic_id}" />
      </c:if>

      <c:if test="${clinic == null}">
        <input type="hidden" name="action" value="insert" />
      </c:if>

      <div class="mb-3">
        <label for="name" class="form-label">Tên Phòng Khám <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="name" name="name"
               value="${clinic.name}" required>
      </div>

      <div class="mb-3">
        <label for="address" class="form-label">Địa Chỉ</label>
        <input type="text" class="form-control" id="address" name="address"
               value="${clinic.address}">
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="hostline" class="form-label">Hotline</label>
          <input type="text" class="form-control" id="hostline" name="hostline"
                 value="${clinic.hostline}">
        </div>
        <div class="col-md-6 mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="email" class="form-control" id="email" name="email"
                 value="${clinic.email}">
        </div>
      </div>

      <div class="mb-3">
        <label for="working_hours" class="form-label">Giờ Làm Việc</label>
        <input type="text" class="form-control" id="working_hours" name="working_hours"
               value="${clinic.working_hours}">
      </div>

      <div class="mb-3">
        <label for="description" class="form-label">Mô Tả</label>
        <textarea class="form-control" id="description" name="description" rows="3">${clinic.description}</textarea>
      </div>

      <div class="mb-4">
        <label for="logo" class="form-label">URL Logo</label>
        <input type="text" class="form-control" id="logo" name="logo"
               value="${clinic.logo}">
        <div class="form-text">Nhập đường dẫn URL của logo.</div>
      </div>

      <div class="d-flex justify-content-end gap-2">
        <a href="${pageContext.request.contextPath}/clinic-info" class="btn btn-secondary">
          <i class="fas fa-times-circle"></i> Hủy
        </a>
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-save"></i>
          <c:choose>
            <c:when test="${clinic != null}">Cập Nhật</c:when>
            <c:otherwise>Thêm Mới</c:otherwise>
          </c:choose>
        </button>
      </div>
    </form>
  </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>