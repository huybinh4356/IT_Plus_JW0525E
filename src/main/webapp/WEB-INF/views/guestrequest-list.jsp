<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Danh sách yêu cầu khách</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body { background-color: #C0C0C0; margin: 0; font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_2.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;}
    .card-table { background: #fff; padding: 25px; border-radius: 16px; box-shadow: 0 6px 15px rgba(0,0,0,.1); margin-top: 30px; }
    h2 { color: #0d6efd; font-weight: 600; text-align: center; margin-bottom: 20px; }
    table { border-radius: 12px; overflow: hidden; }
    thead { background: linear-gradient(45deg,#4e73df,#36b9cc); color: white; text-transform: uppercase; font-weight: bold; }
    td, th { vertical-align: middle !important; }
    .btn { border-radius: 10px; }
    .btn-primary { background: linear-gradient(45deg,#0d6efd,#0b5ed7); border: none; }
    .btn-primary:hover { background: linear-gradient(45deg,#0b5ed7,#0a58ca); }
    .btn-info { background: linear-gradient(45deg,#0dcaf0,#31d2f2); border: none; color: #fff; }
    .btn-warning { background: linear-gradient(45deg,#ffc107,#ffca2c); border: none; color: #000; }
    .btn-danger { background: linear-gradient(45deg,#dc3545,#bb2d3b); border: none; }
    .btn-secondary { background: #6c757d; border-color: #6c757d; color: white; } /* Thêm style cho btn-secondary */
    .btn-secondary:hover { background: #5a6268; border-color: #5a6268; }
    .btn-sm { padding: 4px 10px; font-size: 0.85rem; }
  </style>
</head>
<body>
<div class="container">
  <div class="card-table">
    <h2>Danh sách yêu cầu khách</h2>

    <!-- CẬP NHẬT: Thêm nút Quay về Trang chủ -->
    <div class="d-flex justify-content-between mb-3">
      <a href="<c:url value='/home'/>" class="btn btn-secondary">
        <i class="fas fa-home me-2"></i> Quay về Trang chủ
      </a>
      <a href="guest-requests?action=addForm" class="btn btn-primary">
        <i class="fas fa-plus me-2"></i> Thêm yêu cầu
      </a>
    </div>

    <table class="table table-bordered table-hover align-middle">
      <thead>
      <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Điện thoại</th>
        <th>Email</th>
        <th>Ngày tạo</th>
        <th>Hành động</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="gr" items="${requests}">
        <tr>
          <td>${gr.requestId}</td>
          <td>${gr.fullName}</td>
          <td>${gr.phone}</td>
          <td>${gr.email}</td>
          <td>${gr.createdAt}</td>
          <td>
            <a href="guest-requests?action=detail&id=${gr.requestId}" class="btn btn-info btn-sm"><i class="fas fa-info-circle"></i> Chi tiết</a>
            <a href="guest-requests?action=editForm&id=${gr.requestId}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Sửa</a>
            <a href="guest-requests?action=delete&id=${gr.requestId}" class="btn btn-danger btn-sm"
               onclick="return confirm('Bạn chắc chắn muốn xóa?')"><i class="fas fa-trash-alt"></i> Xóa</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
