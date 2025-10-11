<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><c:if test="${appointment == null}">Đặt Lịch Hẹn Mới</c:if><c:if test="${appointment != null}">Chỉnh Sửa</c:if> Lịch Hẹn</title>
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
      align-items: center;
      justify-content: center;
      overflow: hidden;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;

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
      max-width: 650px;
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

<div class="container d-flex justify-content-center align-items-center vh-100">
  <div class="card-form col-md-8 col-lg-6">
    <h2 class="mb-4"><c:if test="${appointment == null}">Đặt Lịch Hẹn Mới</c:if><c:if test="${appointment != null}">Chỉnh Sửa</c:if> Lịch Hẹn</h2>

    <c:url var="formAction" value="/appointments${appointment == null ? '/new' : '/edit'}" />

    <%-- Lấy role_id từ Session --%>
    <c:set var="userRole" value="${sessionScope.userRoleId}" />

    <form action="${formAction}" method="post">
      <c:if test="${appointment != null}">
        <input type="hidden" name="id" value="${appointment.appointment_id}" />
        <p class="mb-3"><strong>ID Lịch Hẹn:</strong> ${appointment.appointment_id}</p>
        <p class="mb-3"><strong>Mã Hẹn:</strong> ${appointment.appointment_code}</p>
        <input type="hidden" name="code" value="${appointment.appointment_code}" />
      </c:if>

      <div class="row">
        <%-- Patient ID: Dùng ID của user đang đăng nhập (Role 3) hoặc ID được truyền vào (Role 1/2) --%>
        <input type="hidden" name="patientId" value="${appointment != null ? appointment.patient_id.user_id : sessionScope.userId}" />

        <div class="mb-3 col-md-12">
          <label for="serviceId" class="form-label">Dịch Vụ Đặt Lịch:</label>
          <select id="serviceId" name="serviceId" class="form-select" required>
            <option value="" disabled <c:if test="${appointment == null}">selected</c:if>>-- Chọn Dịch Vụ --</option>
            <c:forEach var="service" items="${requestScope.servicesList}">
              <option value="${service.service_id}"
                      <c:if test="${appointment.service_id.service_id == service.service_id}">selected</c:if>>
                  ${service.service_name}
              </option>
            </c:forEach>
          </select>
        </div>
      </div>

      <div class="row">
        <div class="mb-3 col-md-6">
          <label for="date" class="form-label">Ngày:</label>
          <input type="date" id="date" name="date" class="form-control" value="${appointment.appointment_date}" required />
        </div>

        <div class="mb-3 col-md-6">
          <label for="time" class="form-label">Giờ:</label>
          <input type="time" id="time" name="time" class="form-control" value="${appointment.appointment_time}" required />
        </div>
      </div>

      <%-- Ẩn trường Trạng Thái (Status) nếu là Bệnh nhân (Role 3) --%>
      <c:if test="${userRole != 3}">
        <div class="mb-3">
          <label for="status" class="form-label">Trạng Thái:</label>
          <select id="status" name="status" class="form-select">
            <option value="PENDING" <c:if test="${appointment.status == 'PENDING'}">selected</c:if>>Chờ xác nhận</option>
            <option value="CONFIRMED" <c:if test="${appointment.status == 'CONFIRMED'}">selected</c:if>>Đã xác nhận</option>
            <option value="COMPLETED" <c:if test="${appointment.status == 'COMPLETED'}">selected</c:if>>Hoàn thành</option>
            <option value="CANCELLED" <c:if test="${appointment.status == 'CANCELLED'}">selected</c:if>>Hủy</option>
          </select>
        </div>
      </c:if>
      <%-- Nếu là Role 3, cần gửi giá trị trạng thái hiện tại qua hidden field nếu đang chỉnh sửa --%>
      <c:if test="${userRole == 3 && appointment != null}">
        <input type="hidden" name="status" value="${appointment.status}" />
      </c:if>
      <%-- Nếu là Role 3 và đang đặt lịch mới, trạng thái mặc định là PENDING --%>
      <c:if test="${userRole == 3 && appointment == null}">
        <input type="hidden" name="status" value="PENDING" />
      </c:if>

      <div class="mb-4">
        <label for="note" class="form-label">Ghi Chú:</label>
        <textarea id="note" name="note" class="form-control" rows="3">${appointment.note}</textarea>
      </div>

      <div class="d-flex justify-content-between">
        <button type="submit" class="btn btn-success w-50 me-2">
          <i class="fas fa-save me-1"></i> Lưu Lịch Hẹn
        </button>

        <%-- Điều chỉnh nút Hủy/Quay lại --%>
        <c:url var="returnUrl" value="${userRole == 3 ? '/home' : '/appointments'}" />
        <a href="${returnUrl}" class="btn btn-secondary w-50">
          <i class="fas fa-times-circle me-1"></i> Hủy
        </a>
      </div>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>