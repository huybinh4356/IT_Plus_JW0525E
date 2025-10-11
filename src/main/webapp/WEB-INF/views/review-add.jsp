<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thêm Đánh Giá Mới</title>

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
      flex-direction: column;
      align-items: center;
      overflow-x: hidden;
      padding-top: 50px;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }

    .container {
      max-width: 800px; /* Thu nhỏ container cho form */
      width: 100%;
    }

    /* Cần điều chỉnh card-table thành card-form cho form add/edit */
    .card-form {
      background: #ffffff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      border-left: 5px solid #007bff; /* Thay màu border trái cho form */
      z-index: 10;
      position: relative;
    }

    h2 {
      color: #007bff;
      font-weight: 700;
      position: relative;
      margin-bottom: 25px;
    }

    .btn-primary {
      background: #28a745;
      border: none;
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
      transition: all 0.3s ease;
    }
    .btn-primary:hover {
      background: #1e7e34;
    }

    .btn-secondary {
      border-radius: 8px;
      padding: 10px 20px;
      font-weight: 600;
    }

    .form-label {
      font-weight: 500;
      color: #555;
    }
  </style>
</head>
<body>

<div class="container py-4">
  <div class="card-form">
    <a href="reviews" class="btn btn-secondary mb-3 shadow-sm">
      <i class="fas fa-arrow-left me-2"></i> Quay lại Danh sách
    </a>
    <h2 class="text-center">Thêm Đánh Giá Mới</h2>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show">${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <form action="reviews" method="POST">
      <input type="hidden" name="action" value="add">

      <div class="mb-3">
        <label for="patient_id" class="form-label">ID Bệnh Nhân</label>
        <%-- Dùng sessionScope.userId đã được fix trong LoginServlet --%>
        <input type="number" class="form-control" id="patient_id" name="patient_id"
               value="${sessionScope.userId}" readonly required>
      </div>

      <div class="mb-3">
        <label for="service_id" class="form-label">Dịch Vụ Đánh Giá (Tùy chọn)</label>
        <select class="form-select" id="service_id" name="service_id">
          <option value="">-- Chọn Dịch Vụ --</option>
          <c:forEach var="service" items="${servicesUsed}">
            <option value="${service.service_id}">${service.service_name} (ID: ${service.service_id})</option>
          </c:forEach>
          <c:if test="${empty servicesUsed}">
            <option value="" disabled>Không có dịch vụ nào đã sử dụng</option>
          </c:if>
        </select>
      </div>

      <div class="mb-3">
        <label for="appointment_id" class="form-label">Lịch Hẹn Liên Quan (Tùy chọn)</label>
        <select class="form-select" id="appointment_id" name="appointment_id">
          <option value="">-- Chọn Lịch Hẹn --</option>
          <c:forEach var="appt" items="${appointmentsUsed}">
            <option value="${appt.appointment_id}">${appt.appointment_code} - ${appt.appointment_date}</option>
          </c:forEach>
          <c:if test="${empty appointmentsUsed}">
            <option value="" disabled>Không có lịch hẹn nào</option>
          </c:if>
        </select>
      </div>

      <div class="mb-3">
        <label for="rating" class="form-label">Xếp Hạng (1-5) <span class="text-danger">*</span></label>
        <select class="form-select" id="rating" name="rating" required>
          <option value="5">5 sao - Tuyệt vời</option>
          <option value="4">4 sao - Tốt</option>
          <option value="3" selected>3 sao - Bình thường</option>
          <option value="2">2 sao - Kém</option>
          <option value="1">1 sao - Rất Tệ</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="comment" class="form-label">Bình luận</label>
        <textarea class="form-control" id="comment" name="comment" rows="3"></textarea>
      </div>

      <div class="d-grid gap-2">
        <button type="submit" class="btn btn-primary shadow">
          <i class="fas fa-paper-plane me-2"></i> Gửi Đánh Giá
        </button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>