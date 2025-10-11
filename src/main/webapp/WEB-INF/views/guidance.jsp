<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Hướng Dẫn Đăng Ký & Đặt Lịch - DreamTooth</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #f0f2f5;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }
    #content-section{
      background-color: #F5F5F0;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-top: 20px;
      margin-bottom: 20px;
    }
    .content-section {
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-top: 20px;
      margin-bottom: 20px;
    }
    .step-number {
      font-size: 1.5rem;
      color: #0d6efd;
      font-weight: bold;
      margin-right: 10px;
    }
  </style>
</head>
<body>

<div class="container" id="content-section" >
  <h1 class="text-center my-5 text-primary">Chào mừng đến với Nha Khoa DreamTooth</h1>

  <div class="content-section">
    <h3 class="text-success mb-4">🌟 Giới thiệu tổng quan về DreamTooth</h3>
    <p>DreamTooth là hệ thống nha khoa tiên tiến, cam kết mang lại nụ cười hoàn hảo và trải nghiệm quản lý sức khỏe răng miệng tiện lợi nhất cho khách hàng.</p>
    <p>Hệ thống của chúng tôi giúp bạn dễ dàng theo dõi hồ sơ, đặt lịch hẹn với Bác sĩ chuyên khoa và nhận thông báo nhắc lịch tự động. Tất cả các dịch vụ đều được quản lý bởi đội ngũ Lễ tân.</p>
  </div>

  <div class="content-section">
    <h3 class="text-danger mb-4">📝 Hướng dẫn Đăng ký Tài khoản (Dành cho Bệnh nhân)</h3>

    <div class="row g-4">
      <div class="col-md-6">
        <div class="p-3 border rounded">
          <h5 class="step-number d-inline">1.</h5>
          <h5 class="d-inline">Đăng ký Lịch Khám Trực tiếp </h5>
          <p class="mt-2">Nếu bạn chưa từng đến khám, bạn có thể tự đăng ký lịch nhanh không cần tài khoản qua liên kết.</p>
          <a href="guest-requests?action=addForm" class="btn btn-primary">+ Thêm yêu cầu</a>
        </div>
      </div>
      <div class="col-md-6">
        <div class="p-3 border rounded">
          <h5 class="step-number d-inline">2.</h5>
          <h5 class="d-inline">Đăng ký tại Phòng khám</h5>
          <p class="mt-2">Nếu bạn là bệnh nhân lần đầu, **Lễ tân** sẽ hỗ trợ tạo hồ sơ và cấp cho bạn một tài khoản với Tên đăng nhập/Mật khẩu ban đầu ngay tại quầy tiếp đón.</p>
          <a href="<c:url value='/home'/>" class="btn btn-primary">Quay lại trang chủ</a>
        </div>
      </div>
    </div>
  </div>

  <div class="content-section">
    <h3 class="text-info mb-4">🗓 Các bước Đặt lịch Hẹn Nhanh</h3>
    <p>Sau khi có tài khoản, việc đặt lịch hẹn trở nên đơn giản chỉ với vài bước:</p>
    <ol class="list-group list-group-numbered">
      <li class="list-group-item">**Đăng nhập** vào hệ thống bằng tài khoản đã được cấp.</li>
      <li class="list-group-item">Truy cập mục **"Quản lý Lịch hẹn"** trên thanh điều hướng.</li>
      <li class="list-group-item">Chọn **Dịch vụ** và **Bác sĩ** mong muốn (nếu có).</li>
      <li class="list-group-item">Chọn **Ngày** và **Giờ** còn trống trên lịch.</li>
      <li class="list-group-item">Nhấn **Xác nhận**. Hệ thống sẽ ghi nhận lịch hẹn của bạn và gửi thông báo xác nhận.</li>
    </ol>
    <p class="mt-3 text-danger">Hãy đảm bảo bạn nhận được thông báo xác nhận để lịch hẹn được xem là hợp lệ!</p>
  </div>

  <div class="text-center my-4">
    <a href="<c:url value='/login'/>" class="btn btn-primary btn-lg">Quay lại Đăng nhập</a>
  </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>