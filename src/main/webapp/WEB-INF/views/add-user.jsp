<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thêm người dùng</title>
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

    .form-text {
      color: #6c757d;
      font-style: italic;
      font-size: 0.85rem;
      margin-top: 5px;
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

    .alert-danger {
      border-radius: 8px;
      font-weight: 500;
      border-left: 5px solid #dc3545;
      background-color: #fff3f3;
    }

    .btn i {
      margin-right: 5px;
    }

    .container.mt-5 {
      padding-top: 0;
      padding-bottom: 0;
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

<div class="container mt-5">
  <div class="card-form col-md-10 mx-auto">
    <h2>Thêm người dùng</h2>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
          ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/users?action=add">
      <div class="row">
        <div class="col-md-6">
          <div class="mb-3">
            <label class="form-label">Tên đăng nhập</label>
            <input type="text" name="username" class="form-control"
                   value="${user.username}" required/>
            <div class="form-text">Tên đăng nhập phải là duy nhất</div>
          </div>
          <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input type="password" name="password_hash" class="form-control"
                   value="${password_hash}" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" name="full_name" class="form-control"
                   value="${user.full_name}" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Ngày sinh</label>
            <input type="date" name="dob" class="form-control"
                   value="${user.dob}"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Giới tính</label>
            <select name="gender" class="form-select" required>
              <option value="">-- Chọn giới tính --</option>
              <option value="Nam" ${user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
              <option value="Nữ" ${user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">CCCD</label>
            <input type="text" name="cccd" class="form-control"
                   value="${user.cccd}"/>
          </div>
        </div>

        <div class="col-md-6">
          <div class="mb-3">
            <label class="form-label">SĐT</label>
            <input type="text" name="phone" class="form-control"
                   value="${user.phone}"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control"
                   value="${user.email}"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="address" class="form-control"
                   value="${user.address}"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Vai trò</label>
            <select name="role_id" class="form-select" required>
              <option value="">-- Chọn vai trò --</option>
              <option value="1" ${user.role_id == 1 ? 'selected' : ''}>Quản trị</option>
              <option value="2" ${user.role_id == 2 ? 'selected' : ''}>Bác sĩ</option>
              <option value="3" ${user.role_id == 3 ? 'selected' : ''}>Bệnh nhân</option>
            </select>
          </div>

          <div class="mb-3">
            <label class="form-label">Chuyên ngành</label>
            <select name="specialty_id" class="form-select">
              <option value="">-- Không chọn --</option>
              <c:forEach var="spec" items="${specialties}">
                <option value="${spec.specialtyId}"
                        <c:if test="${not empty user.specialty}">
                          ${user.specialty.specialtyId == spec.specialtyId ? 'selected' : ''}
                        </c:if>
                >
                    ${spec.name}
                </option>
              </c:forEach>
            </select>
          </div>

          <div class="mb-3">
            <label class="form-label">Bằng cấp</label>
            <input type="text" name="degree" class="form-control"
                   value="${user.degree}"/>
          </div>
          <div class="mb-3">
            <label class="form-label">Chức vụ</label>
            <input type="text" name="position" class="form-control"
                   value="${user.position}"/>
          </div>

          <div class="mb-3 form-check d-flex align-items-center">
            <input type="checkbox" name="is_active" class="form-check-input me-2" id="isActive"
            ${user.is_active || empty user.is_active ? 'checked' : ''}/>
            <label class="form-check-label" for="isActive">Hoạt động</label>
          </div>
        </div>
      </div>

      <hr class="my-4">

      <div class="d-flex justify-content-end gap-2">
        <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary">
          <i class="fas fa-times-circle"></i> Hủy
        </a>
        <button type="submit" class="btn btn-success">
          <i class="fas fa-save"></i> Lưu người dùng
        </button>
      </div>
    </form>
  </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>