<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách người dùng</title>
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
      flex-direction: column;
      align-items: center;
      overflow-x: hidden;
      padding-top: 50px;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .container {
      max-width: 1200px;
      width: 100%;
    }

    .card-form {
      background: #ffffff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0,0,0,.15);
      border-left: 5px solid #007bff;
      z-index: 10;
      position: relative;
    }

    h2 {
      color: #007bff;
      font-weight: 700;
      text-align: center;
      margin-bottom: 30px;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
      transition: all .2s;
    }
    .form-control:focus, .form-select:focus {
      border-color: #0d6efd;
      box-shadow: 0 0 0 4px rgba(13,110,253,.15);
    }

    .btn-primary, .btn-success, .btn-secondary, .btn-info, .btn-danger {
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.2s ease;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .btn-primary {
      background-color: #0d6efd; border-color: #0d6efd;
    }
    .btn-success {
      background-color: #28a745; border-color: #28a745;
    }
    .btn-info {
      background-color: #17a2b8; border-color: #17a2b8;
      color: white;
    }
    .btn-secondary {
      background-color: #6c757d; border-color: #6c757d;
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
    td {
      font-size: 0.9rem;
      vertical-align: middle !important;
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
    <c:set var="userRole" value="${sessionScope.userRoleId + 0}" scope="request" />
    <c:set var="currentUserId" value="${sessionScope.userId + 0}" scope="request" />

    <c:choose>
      <c:when test="${userRole == 1}">
        <h2><i class="fas fa-users me-2"></i> Quản lý & Danh sách người dùng</h2>
      </c:when>
      <c:when test="${userRole == 2}">
        <h2><i class="fas fa-user-md me-2"></i> Hồ sơ cá nhân Bác sĩ</h2>
      </c:when>
      <c:when test="${userRole == 3}">
        <h2><i class="fas fa-hospital-user me-2"></i> Hồ sơ cá nhân Bệnh nhân</h2>
      </c:when>
      <c:otherwise>
        <h2><i class="fas fa-users me-2"></i> Hồ sơ người dùng</h2>
      </c:otherwise>
    </c:choose>

    <c:if test="${userRole == 1}">
      <form class="row g-3 mb-4 align-items-end" method="get" action="${pageContext.request.contextPath}/users">
        <input type="hidden" name="action" value="list"/>
        <div class="col-md-4">
          <label for="searchType" class="form-label small text-muted mb-1">Loại tìm kiếm</label>
          <select id="searchType" name="searchType" class="form-select" required>
            <option value="" ${empty param.searchType ? 'selected' : ''}>-- Chọn loại tìm kiếm --</option>
            <option value="name" ${param.searchType eq 'name' ? 'selected' : ''}>Tên</option>
            <option value="gender" ${param.searchType eq 'gender' ? 'selected' : ''}>Giới tính</option>
            <option value="address" ${param.searchType eq 'address' ? 'selected' : ''}>Địa chỉ</option>
            <option value="cccd" ${param.searchType eq 'cccd' ? 'selected' : ''}>CCCD</option>
            <option value="phone" ${param.searchType eq 'phone' ? 'selected' : ''}>SĐT</option>
          </select>
        </div>
        <div class="col-md-4" id="keywordContainer">
          <label for="keyword" class="form-label small text-muted mb-1">Từ khóa</label>
          <c:choose>
            <c:when test="${param.searchType eq 'gender'}">
              <select name="keyword" class="form-select" required>
                <option value="">-- Chọn giới tính --</option>
                <option value="Nam" ${param.keyword eq 'Nam' ? 'selected' : ''}>Nam</option>
                <option value="Nữ" ${param.keyword eq 'Nữ' ? 'selected' : ''}>Nữ</option>
              </select>
            </c:when>
            <c:otherwise>
              <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Nhập từ khóa..." value="${param.keyword != null ? param.keyword : ''}"/>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="col-md-2">
          <button type="submit" class="btn btn-primary w-100">
            <i class="fas fa-search me-1"></i> Tìm
          </button>
        </div>
        <div class="col-md-2">
          <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary w-100">
            <i class="fas fa-redo me-1"></i> Reset
          </a>
        </div>
      </form>
    </c:if>

    <div class="row g-3 mb-4">

      <div class="${userRole == 1 ? 'col-md-3' : 'col-md-12'}">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-info w-100 shadow-sm">
          <i class="fas fa-home me-1"></i> Về Trang chủ
        </a>
      </div>

      <c:if test="${userRole == 1}">
        <div class="col-md-3">
          <a href="${pageContext.request.contextPath}/users?action=addForm" class="btn btn-success w-100 shadow-sm">
            <i class="fas fa-plus me-1"></i> Thêm người dùng
          </a>
        </div>
        <div class="col-md-3">
          <a href="${pageContext.request.contextPath}/specialties" class="btn btn-secondary w-100 shadow-sm">
            <i class="fas fa-stethoscope me-1"></i> Quản lý chuyên khoa
          </a>
        </div>

        <%-- NÚT XUẤT FILE CSV (Chỉ hiển thị cho Admin) --%>
        <div class="col-md-3">
          <a href="${pageContext.request.contextPath}/export-patients" class="btn btn-danger w-100 shadow-sm">
            <i class="fas fa-file-csv me-1"></i> Xuất DS Bệnh nhân
          </a>
        </div>
      </c:if>

    </div>

    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle mb-0">
        <thead>
        <tr>
          <th style="width: 5%;">ID</th>
          <th style="width: 18%;">Họ tên</th>
          <th style="width: 10%;">Vai trò</th>
          <th style="width: 8%;">Giới tính</th>
          <th style="width: 10%;">SĐT</th>
          <th style="width: 18%;">Email</th>
          <th style="width: 16%;">Địa chỉ</th>
          <th style="width: 15%;">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
          <tr>
            <td>${user.user_id}</td>
            <td><strong class="text-primary">${user.full_name}</strong></td>
            <td>
              <c:choose>
                <c:when test="${user.role_id == 1}"><span class="badge bg-danger"><i class="fas fa-user-tie"></i> Admin</span></c:when>
                <c:when test="${user.role_id == 2}"><span class="badge bg-info"><i class="fas fa-user-md"></i> Bác sĩ</span></c:when>
                <c:when test="${user.role_id == 3}"><span class="badge bg-success"><i class="fas fa-hospital-user"></i> Bệnh nhân</span></c:when>
                <c:otherwise><span class="badge bg-secondary">Khác</span></c:otherwise>
              </c:choose>
            </td>
            <td>${user.gender}</td>
            <td>${user.phone}</td>
            <td>${user.email}</td>
            <td>
                            <span class="d-inline-block text-truncate" style="max-width: 150px;">
                                ${user.address}
                            </span>
            </td>
            <td class="text-nowrap">
              <a href="${pageContext.request.contextPath}/users?action=detail&id=${user.user_id}" class="btn btn-sm btn-info me-1">
                <i class="fas fa-info-circle"></i> Chi tiết
              </a>

              <c:if test="${userRole == 1}">
                <a href="${pageContext.request.contextPath}/users?action=editForm&id=${user.user_id}" class="btn btn-sm btn-primary me-1">
                  <i class="fas fa-edit"></i> Sửa
                </a>
                <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.user_id}"
                   class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng ID: ${user.user_id} này không?');">
                  <i class="fas fa-trash-alt"></i> Xóa
                </a>
              </c:if>

            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty users}">
          <tr>
            <td colspan="8" class="text-center text-muted py-4">
              <i class="fas fa-exclamation-circle me-2"></i> Không tìm thấy người dùng nào.
            </td>
          </tr>
        </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const sel = document.getElementById("searchType");
    const container = document.getElementById("keywordContainer");

    if (!sel) return;

    const currentSearchType = sel.value;

    if (currentSearchType !== "gender") {
      if (container.children.length === 0) {
        // Khởi tạo input text nếu chưa có
        const label = document.createElement('label');
        label.setAttribute('for', 'keyword');
        label.setAttribute('class', 'form-label small text-muted mb-1');
        label.textContent = 'Từ khóa';
        container.appendChild(label);

        const input = document.createElement('input');
        input.setAttribute('type', 'text');
        input.setAttribute('id', 'keyword');
        input.setAttribute('name', 'keyword');
        input.setAttribute('class', 'form-control');
        input.setAttribute('placeholder', 'Nhập từ khóa...');
        // Đặt giá trị cũ nếu có
        input.value = "${param.keyword != null ? param.keyword : ''}";
        container.appendChild(input);
      }
    }

    function renderKeywordInput(type) {
      container.innerHTML = '';

      const label = document.createElement('label');
      label.setAttribute('class', 'form-label small text-muted mb-1');
      label.textContent = 'Từ khóa';
      container.appendChild(label);

      if (type === "gender") {
        const select = document.createElement('select');
        select.setAttribute('name', 'keyword');
        select.setAttribute('class', 'form-select');
        select.setAttribute('required', 'true');

        select.innerHTML =
                '<option value="">-- Chọn giới tính --</option>' +
                '<option value="Nam">Nam</option>' +
                '<option value="Nữ">Nữ</option>';
        container.appendChild(select);
      } else {
        const input = document.createElement('input');
        input.setAttribute('type', 'text');
        input.setAttribute('id', 'keyword');
        input.setAttribute('name', 'keyword');
        input.setAttribute('class', 'form-control');
        input.setAttribute('placeholder', 'Nhập từ khóa...');
        container.appendChild(input);
      }
    }

    sel && sel.addEventListener('change', function () {
      renderKeywordInput(this.value);
    });
  });
</script>
</body>
</html>