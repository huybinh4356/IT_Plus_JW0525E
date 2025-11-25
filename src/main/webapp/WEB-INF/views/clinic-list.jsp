<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông Tin Phòng Khám & Đăng Ký</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/images/img_10.png" type="image/png">
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

    /* Thẻ nội dung chung */
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

    /* Card cho form đăng ký nhanh */
    .form-card-register {
      border-left-color: #28a745; /* Màu xanh lá cho form */
    }

    /* Tiêu đề trang chính */
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

    /* Tiêu đề phụ (cho 2 thẻ card) */
    h2 {
      color: #007bff;
      font-weight: 700;
      text-align: center;
      margin-bottom: 25px;
      position: relative;
      font-size: 1.75rem;
    }
    h2.text-success { color: #28a745 !important; }

    h2::after {
      content: '';
      position: absolute;
      bottom: -5px;
      left: 50%;
      transform: translateX(-50%);
      width: 70px;
      height: 3px;
      background-color: currentColor; /* Lấy màu của chữ (xanh dương hoặc xanh lá) */
      border-radius: 2px;
    }

    /* ---- CSS CHO FORM ĐĂNG KÝ ---- */
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
      transition: all 0.3s ease;
    }
    .form-control:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
    }
    /* ---- KẾT THÚC CSS FORM ---- */

    /* ---- CSS CHO NÚT BẤM ---- */
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
    .btn-success {
      background: #28a745;
      box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
    }
    .btn-success:hover {
      background: #1e7e34;
      transform: translateY(-1px);
    }
    .btn-info, .btn-warning, .btn-danger {
      border-radius: 6px;
      font-weight: 500;
    }
    /* ---- KẾT THÚC CSS NÚT BẤM ---- */


    .clinic-card {
      transition: all 0.3s ease;
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      overflow: hidden; /* Bắt buộc để bo góc ảnh */
      background: #fff;
      margin-bottom: 1.5rem; /* Thay cho .g-4 của row */
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    }
    .clinic-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    /* Vùng chứa logo bên trái thẻ */
    .clinic-logo-wrapper {
      background-color: #f8f9fa; /* Nền xám nhạt cho logo */
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      border-right: 1px solid #eee;
    }

    /* Logo (hiển thị dạng tròn) */
    .clinic-logo {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 50%; /* Bo tròn logo */
      border: 4px solid #ffffff;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .clinic-card .card-body {
      padding: 25px;
    }

    .clinic-card .card-title {
      color: #007bff;
      font-weight: 600;
      margin-bottom: 15px;
      font-size: 1.3rem;
    }

    /* Danh sách thông tin (SĐT, Mail, Địa chỉ) */
    .clinic-info-list {
      list-style: none;
      padding-left: 0;
      font-size: 0.95rem;
      color: #555;
    }
    .clinic-info-list li {
      margin-bottom: 8px;
      display: flex;
      align-items: flex-start;
    }
    .clinic-info-list .fa-fw {
      margin-right: 10px;
      color: #007bff;
      width: 20px; /* Căn chỉnh các icon thẳng hàng */
      text-align: center;
      padding-top: 3px;
    }

    /* Vùng chứa nút (Xem, Sửa, Xóa) */
    .card-actions {
      margin-top: 20px;
      padding-top: 15px;
      border-top: 1px solid #eee;
      text-align: right;
    }
    /* ---------------------------------------------------- */
    /* ---- KẾT THÚC CSS REDESIGN ---- */
    /* ---------------------------------------------------- */


    /* Hiệu ứng nền */
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

  <h1>Thông Tin Phòng Khám & Đăng Ký</h1>

  <div class="mb-3">
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
      <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
    </a>
  </div>

  <div class="row g-4">

    <div class="col-lg-8">
      <div class="content-card">

        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0 text-start" style="font-size: 1.7rem;">
            <i class="fas fa-hospital me-2"></i> Danh Sách Phòng Khám
          </h2>
          <c:if test="${sessionScope.userRoleId == 1}">
            <a href="clinic-info?action=new" class="btn btn-primary btn-sm">
              <i class="fas fa-plus me-2"></i> Thêm Mới
            </a>
          </c:if>
        </div>

        <c:choose>
          <c:when test="${empty clinicList}">
            <div class="alert alert-warning" role="alert">
              <i class="fas fa-exclamation-triangle me-2"></i> Hiện chưa có thông tin phòng khám nào.
            </div>
          </c:when>

          <c:otherwise>
            <%-- Bắt đầu vòng lặp, mỗi clinic là 1 card --%>
            <c:forEach var="clinic" items="${clinicList}">
              <div class="card clinic-card shadow-sm">
                <div class="row g-0">

                  <div class="col-md-3 clinic-logo-wrapper">
                    <img src="${pageContext.request.contextPath}/assets/images/img_10.png"
                         alt="Logo ${clinic.name}"
                         class="clinic-logo">
                  </div>
                  <div class="col-md-9">
                    <div class="card-body">
                      <h5 class="card-title">${clinic.name}</h5>

                      <ul class="clinic-info-list">
                        <li>
                          <i class="fas fa-phone fa-fw"></i>
                          <span>${clinic.hostline}</span>
                        </li>
                        <li>
                          <i class="fas fa-envelope fa-fw"></i>
                          <span>${clinic.email}</span>
                        </li>
                        <li>
                          <i class="fas fa-map-marker-alt fa-fw"></i>
                          <span>${clinic.address}</span>
                        </li>
                        <li>
                          <i class="fas fa-clock fa-fw"></i>
                          <span>${clinic.working_hours}</span>
                        </li>
                      </ul>

                      <div class="card-actions">
                        <button type="button" class="btn btn-info btn-sm me-1 text-white"
                                data-bs-toggle="modal" data-bs-target="#detailModal${clinic.clinic_id}">
                          <i class="fas fa-eye"></i> Xem thêm
                        </button>

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
                      </div>

                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
            <%-- Kết thúc vòng lặp --%>
          </c:otherwise>
        </c:choose>

      </div>
    </div> <div class="col-lg-4">
    <div class="content-card form-card-register">
      <h2 class="text-success">
        <i class="fas fa-calendar-alt me-2"></i> Đăng Ký Nhanh
      </h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="font-size: 0.9rem;">
          <i class="fas fa-exclamation-triangle me-2"></i> ${error}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <form method="post" action="guest-requests">
        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="userRoleId" value="${sessionScope.userRoleId}"/>

        <div class="mb-3">
          <label class="form-label">Họ tên</label>
          <input type="text" name="fullName" class="form-control" placeholder="Nguyễn Văn A" value="${requestObj.fullName}" required/>
        </div>
        <div class="mb-3">
          <label class="form-label">Điện thoại</label>
          <input type="text" name="phone" class="form-control" placeholder="09xxxxxxxx" value="${requestObj.phone}" required/>
        </div>
        <div class="mb-3">
          <label class="form-label">Email</label>
          <input type="email" name="email" class="form-control" placeholder="vidu@email.com" value="${requestObj.email}"/>
        </div>
        <div class="mb-3">
          <label class="form-label">CCCD</label>
          <input type="text" name="cccd" class="form-control" placeholder="0011xxxxxxxx" value="${requestObj.cccd}"/>
        </div>
        <div class="mb-3">
          <label class="form-label">Địa chỉ</label>
          <input type="text" name="address" class="form-control" placeholder="Số nhà, đường, quận/huyện" value="${requestObj.address}"/>
        </div>
        <div class="mb-4">
          <label class="form-label">Lời nhắn</label>
          <textarea name="message" class="form-control" rows="3" placeholder="Mô tả sơ qua vấn đề...">${requestObj.message}</textarea>
        </div>
        <div class="d-grid">
          <button type="submit" class="btn btn-success">
            <i class="fas fa-paper-plane me-2"></i> Gửi Yêu cầu
          </button>
        </div>
      </form>

    </div>
  </div> </div> </div> <c:forEach var="clinic" items="${clinicList}">
  <div class="modal fade" id="detailModal${clinic.clinic_id}" tabindex="-1"
       aria-labelledby="detailModalLabel${clinic.clinic_id}" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="detailModalLabel${clinic.clinic_id}">Chi Tiết Phòng Khám: ${clinic.name}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <dl class="row">
            <dt class="col-sm-4 text-muted">Mã ID:</dt>
            <dd class="col-sm-8">${clinic.clinic_id}</dd>

            <dt class="col-sm-4 text-muted">Tên Phòng Khám:</dt>
            <dd class="col-sm-8">${clinic.name}</dd>

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

            <dt class="col-sm-4 text-muted">Logo URL:</dt>
            <dd class="col-sm-8"><code>${clinic.logo}</code></dd>
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