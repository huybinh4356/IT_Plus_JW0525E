<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thêm dịch vụ</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
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
      background-image: url('${pageContext.request.contextPath}/assets/images/img_2.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
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
      max-width: 900px;
    }
    .card-form:hover {
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
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

    .form-check-input:checked {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-success {
      background: #007bff;
      border: none;
      border-radius: 8px;
      padding: 10px 25px;
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

    .btn i {
      margin-right: 5px;
    }

    .container.py-5 {
      padding-top: 0 !important;
      padding-bottom: 0 !important;
      display: flex;
      justify-content: center;
      align-items: center;
      height: auto;
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

<div class="container py-5">
  <div class="card-form p-4 shadow-lg">
    <h2 class="mb-4">Thêm dịch vụ mới</h2>

    <form action="${pageContext.request.contextPath}/services?action=add" method="post">
      <div class="row g-3">
        <div class="col-md-6">
          <input type="text" name="service_name" class="form-control" placeholder="Tên dịch vụ" required>
        </div>
        <div class="col-md-6">
          <input type="text" name="category" class="form-control" placeholder="Danh mục">
        </div>
        <div class="col-md-12">
          <textarea name="description" class="form-control" placeholder="Mô tả"></textarea>
        </div>
        <div class="col-md-6">
          <input type="text" name="target_customer" class="form-control" placeholder="Khách hàng mục tiêu">
        </div>
        <div class="col-md-6">
          <input type="text" name="process" class="form-control" placeholder="Quy trình">
        </div>
        <div class="col-md-6">
          <input type="text" name="technology" class="form-control" placeholder="Công nghệ">
        </div>
        <div class="col-md-6">
          <input type="text" name="duration" class="form-control" placeholder="Thời gian thực hiện">
        </div>
        <div class="col-md-6">
          <input type="text" name="warranty_policy" class="form-control" placeholder="Chính sách bảo hành">
        </div>
        <div class="col-md-6">
          <input type="number" step="0.01" name="price" class="form-control" placeholder="Giá" required>
        </div>
        <div class="col-md-12">
          <div class="form-check">
            <input type="hidden" name="is_active" value="0">
            <input type="checkbox" name="is_active" value="1" class="form-check-input" id="activeCheck" checked>
            <label for="activeCheck" class="form-check-label">Kích hoạt dịch vụ</label>
          </div>
        </div>
        <div class="col-md-12 text-center mt-3">
          <button type="submit" class="btn btn-success px-4">
            <i class="fas fa-plus"></i> Thêm dịch vụ
          </button>
          <a href="${pageContext.request.contextPath}/services?action=list" class="btn btn-secondary px-4">
            <i class="fas fa-list"></i> Quay lại danh sách
          </a>
        </div>
      </div>
    </form>
  </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>