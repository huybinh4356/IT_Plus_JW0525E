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
  <link rel="icon" href="${pageContext.request.contextPath}/assets/images/logo-icon.png" type="image/png">

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

    .sidebar-card {
      background: #ffffff;
      padding: 25px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-left: 5px solid #17a2b8; /* Màu xanh cyan cho sidebar */
      z-index: 10;
      position: relative;
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
      width: 100px;
      height: 3px;
      background-color: #007bff;
      border-radius: 2px;
    }

    h2 {
      color: #007bff;
      font-weight: 700;
      margin-bottom: 20px;
      font-size: 1.5rem;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
    }
    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
    }

    .btn {
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.2s ease;
    }

    /* Table Styles */
    table {
      border-radius: 12px;
      overflow: hidden;
    }
    thead {
      background-color: #007bff;
      color: white;
      text-transform: uppercase;
      font-weight: 600;
    }
    thead th { padding: 15px 12px; }
    tbody tr:hover { background-color: #f8f9fa; }
    td { vertical-align: middle !important; font-size: 0.9rem; }

    /* Background shapes */
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

  <c:set var="userRole" value="${sessionScope.userRoleId + 0}" scope="request" />

  <%-- TIÊU ĐỀ TRANG --%>
  <h1>
    <c:choose>
      <c:when test="${userRole == 1}"><i class="fas fa-users-cog me-2"></i> Quản Lý Người Dùng</c:when>
      <c:when test="${userRole == 2}"><i class="fas fa-user-md me-2"></i> Hồ Sơ Bác Sĩ</c:when>
      <c:when test="${userRole == 3}"><i class="fas fa-hospital-user me-2"></i> Hồ Sơ Của Tôi</c:when>
      <c:otherwise>Hồ Sơ Người Dùng</c:otherwise>
    </c:choose>
  </h1>

  <div class="mb-3">
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
      <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
    </a>
  </div>

  <div class="row g-4">

    <%-- ================= CỘT TRÁI: DANH SÁCH NGƯỜI DÙNG (COL-8) ================= --%>
    <div class="col-lg-8">
      <div class="content-card">

        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0 text-start"><i class="fas fa-list-ul me-2"></i> Danh sách</h2>
          <c:if test="${userRole == 1}">
            <a href="${pageContext.request.contextPath}/users?action=addForm" class="btn btn-primary shadow-sm">
              <i class="fas fa-user-plus me-2"></i> Thêm Mới
            </a>
          </c:if>
        </div>

        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle mb-0">
            <thead>
            <tr>
              <th>ID</th>
              <th>Họ tên</th>
              <th>Vai trò</th>
              <th>Giới tính</th>
              <th>SĐT</th>
              <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
              <tr>
                <td>${user.user_id}</td>
                <td>
                  <div class="d-flex align-items-center">
                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                      <i class="fas fa-user text-secondary"></i>
                    </div>
                    <div>
                      <strong class="text-primary d-block">${user.full_name}</strong>
                      <small class="text-muted">${user.email}</small>
                    </div>
                  </div>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${user.role_id == 1}"><span class="badge bg-danger">Admin</span></c:when>
                    <c:when test="${user.role_id == 2}"><span class="badge bg-info text-dark">Bác sĩ</span></c:when>
                    <c:when test="${user.role_id == 3}"><span class="badge bg-success">Bệnh nhân</span></c:when>
                    <c:otherwise><span class="badge bg-secondary">Khác</span></c:otherwise>
                  </c:choose>
                </td>
                <td>${user.gender}</td>
                <td>${user.phone}</td>
                <td class="text-nowrap">
                  <a href="${pageContext.request.contextPath}/users?action=detail&id=${user.user_id}" class="btn btn-sm btn-info text-white me-1" title="Chi tiết">
                    <i class="fas fa-info-circle"></i>
                  </a>

                  <c:if test="${userRole == 1}">
                    <a href="${pageContext.request.contextPath}/users?action=editForm&id=${user.user_id}" class="btn btn-sm btn-warning me-1" title="Sửa">
                      <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.user_id}"
                       class="btn btn-sm btn-danger" title="Xóa"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng ${user.full_name} (ID: ${user.user_id})?');">
                      <i class="fas fa-trash-alt"></i>
                    </a>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty users}">
              <tr>
                <td colspan="6" class="text-center text-muted py-4">
                  <i class="fas fa-search-minus fa-2x mb-2"></i><br>
                  Không tìm thấy người dùng nào.
                </td>
              </tr>
            </c:if>
            </tbody>
          </table>
        </div>

      </div>
    </div>

    <%-- ================= CỘT PHẢI: TÌM KIẾM & CHỨC NĂNG PHỤ (COL-4) ================= --%>
    <div class="col-lg-4">

      <%-- Form Tìm Kiếm (Chỉ hiện cho Admin) --%>
      <c:if test="${userRole == 1}">
        <div class="sidebar-card mb-4">
          <h2 class="text-info" style="font-size: 1.3rem;"><i class="fas fa-search me-2"></i> Tra cứu</h2>
          <hr>
          <form method="get" action="${pageContext.request.contextPath}/users">
            <input type="hidden" name="action" value="list"/>

            <div class="mb-3">
              <label for="searchType" class="form-label small text-muted">Tiêu chí tìm kiếm</label>
              <select id="searchType" name="searchType" class="form-select" required>
                <option value="" ${empty param.searchType ? 'selected' : ''}>-- Chọn tiêu chí --</option>
                <option value="name" ${param.searchType eq 'name' ? 'selected' : ''}>Tên</option>
                <option value="gender" ${param.searchType eq 'gender' ? 'selected' : ''}>Giới tính</option>
                <option value="address" ${param.searchType eq 'address' ? 'selected' : ''}>Địa chỉ</option>
                <option value="cccd" ${param.searchType eq 'cccd' ? 'selected' : ''}>CCCD</option>
                <option value="phone" ${param.searchType eq 'phone' ? 'selected' : ''}>SĐT</option>
              </select>
            </div>

            <div class="mb-3" id="keywordContainer">
              <label for="keyword" class="form-label small text-muted">Từ khóa</label>
              <c:choose>
                <c:when test="${param.searchType eq 'gender'}">
                  <select name="keyword" class="form-select">
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

            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-info text-white">
                <i class="fas fa-filter me-2"></i> Lọc kết quả
              </button>
              <a href="${pageContext.request.contextPath}/users" class="btn btn-outline-secondary">
                <i class="fas fa-sync-alt me-2"></i> Làm mới
              </a>
            </div>
          </form>
        </div>

        <%-- Chức năng mở rộng (Chỉ Admin) --%>
        <div class="sidebar-card" style="border-left-color: #ffc107;">
          <h2 class="text-warning" style="font-size: 1.3rem;"><i class="fas fa-tools me-2"></i> Tiện ích</h2>
          <hr>
          <div class="d-grid gap-3">
            <a href="${pageContext.request.contextPath}/specialties" class="btn btn-outline-dark text-start">
              <i class="fas fa-stethoscope me-2 text-success"></i> Quản lý chuyên khoa
            </a>
            <a href="${pageContext.request.contextPath}/export-patients" class="btn btn-outline-dark text-start">
              <i class="fas fa-file-csv me-2 text-success"></i> Xuất Excel DS Bệnh nhân
            </a>
          </div>
        </div>
      </c:if>

      <%-- Thông tin tóm tắt (Hiện cho mọi role) --%>
      <c:if test="${userRole != 1}">
        <div class="sidebar-card">
          <h2 class="text-info" style="font-size: 1.3rem;"><i class="fas fa-info-circle me-2"></i> Thông tin</h2>
          <hr>
          <p class="text-muted small">Đây là trang quản lý thông tin cá nhân của bạn. Hãy cập nhật thông tin chính xác để bác sĩ có thể liên hệ dễ dàng.</p>
        </div>
      </c:if>

    </div>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const sel = document.getElementById("searchType");
    const container = document.getElementById("keywordContainer");

    if (!sel) return;

    // Hàm render input dựa trên loại tìm kiếm
    function renderKeywordInput(type) {
      container.innerHTML = ''; // Xóa nội dung cũ

      const label = document.createElement('label');
      label.setAttribute('class', 'form-label small text-muted');
      label.textContent = 'Từ khóa';
      container.appendChild(label);

      if (type === "gender") {
        const select = document.createElement('select');
        select.setAttribute('name', 'keyword');
        select.setAttribute('class', 'form-select');
        select.innerHTML =
                '<option value="">-- Chọn giới tính --</option>' +
                '<option value="Nam">Nam</option>' +
                '<option value="Nữ">Nữ</option>';
        container.appendChild(select);
      } else {
        const input = document.createElement('input');
        input.setAttribute('type', 'text');
        input.setAttribute('name', 'keyword');
        input.setAttribute('class', 'form-control');
        input.setAttribute('placeholder', 'Nhập từ khóa...');
        container.appendChild(input);
      }
    }

    sel.addEventListener('change', function () {
      renderKeywordInput(this.value);
    });
  });
</script>
</body>
</html>