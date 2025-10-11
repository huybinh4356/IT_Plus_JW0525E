<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Sửa chuyên khoa</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body { background-color: #C0C0C0; margin: 0; font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;}
    .card-form { background: #ffffff; padding: 30px; border-radius: 16px; box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1); }
    h2 { color: #0d6efd; font-weight: 600; text-align: center; margin-bottom: 25px; }
    .form-control { border-radius: 10px; transition: all 0.2s ease-in-out; }
    .form-control:focus { border-color: #0d6efd; box-shadow: 0 0 6px rgba(13, 110, 253, 0.4); }
    .btn-success { background: linear-gradient(45deg, #198754, #28a745); border: none; border-radius: 10px; }
    .btn-success:hover { background: linear-gradient(45deg, #157347, #218838); }
    .btn-secondary { border-radius: 10px; }
  </style>
</head>
<body>
<div class="container py-5">
  <div class="card-form col-md-6 mx-auto">
    <h2>Sửa chuyên khoa</h2>
    <form method="post" action="specialties">
      <input type="hidden" name="action" value="update"/>
      <input type="hidden" name="id" value="${specialty.specialtyId}"/>
      <div class="mb-3">
        <label class="form-label">Tên chuyên khoa</label>
        <input type="text" name="name" class="form-control" value="${specialty.name}" required/>
      </div>
      <div class="mb-3">
        <label class="form-label">Mô tả</label>
        <textarea name="description" class="form-control" rows="4">${specialty.description}</textarea>
      </div>
      <div class="d-flex justify-content-between">
        <a href="specialties" class="btn btn-secondary">Quay lại</a>
        <button type="submit" class="btn btn-success">Cập nhật</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>