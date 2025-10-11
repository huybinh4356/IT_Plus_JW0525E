<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chi tiết yêu cầu khách</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body { background-color: #f8f9fa; font-family: 'Inter', sans-serif; }
    .detail-card {
      max-width: 800px;
      margin: 40px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      background-color: #ffffff;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }
    .table th {
      width: 30%;
      font-weight: 600;
      color: #495057;
    }
    .table td {
      word-wrap: break-word;
      word-break: break-all;
    }
  </style>
</head>
<body>
<div class="detail-card">
  <h2 class="mb-4 text-primary border-bottom pb-2">Chi tiết yêu cầu khách</h2>

  <!-- Hiển thị dữ liệu từ requestObj được truyền từ Servlet -->
  <table class="table table-striped table-bordered">
    <tbody>
    <tr><th>ID</th><td>${requestObj.requestId}</td></tr>
    <tr><th>Họ tên</th><td>${requestObj.fullName}</td></tr>
    <tr><th>Điện thoại</th><td>${requestObj.phone}</td></tr>
    <tr><th>Email</th><td>${requestObj.email}</td></tr>
    <tr><th>CCCD</th><td>${requestObj.cccd}</td></tr>
    <tr><th>Địa chỉ</th><td>${requestObj.address}</td></tr>
    <tr><th>Lời nhắn</th><td>${requestObj.message}</td></tr>
    <tr><th>Ngày tạo</th><td>${requestObj.createdAt}</td></tr>
    </tbody>
  </table>

  <!-- Nút quay lại, giả định đường dẫn là '/guest-requests' hoặc một Servlet quản lý danh sách -->
  <div class="mt-4">
    <a href="<c:url value='/guest-requests'/>" class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i> Quay lại Danh sách</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
