<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thêm Hồ sơ Bệnh án mới</title>
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
      overflow: hidden;
      padding-top: 50px;
      padding-bottom: 50px;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }

    .container {
      max-width: 900px;
    }

    .card {
      background: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
      border-left: 5px solid #007bff;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
    }
    .card:hover {
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    }

    .card-header {
      background-color: #007bff !important;
      border-bottom: none;
      border-radius: 8px 8px 0 0;
      padding: 15px 20px;
    }

    h3 {
      font-weight: 700;
      text-align: center;
      margin-bottom: 0;
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
      background-color: rgba(255, 255, 255, 0.9);
      transition: all 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
      background-color: #fff;
    }

    .btn-success {
      background: #28a745;
      border: none;
      border-radius: 8px;
      padding: 12px 25px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
      transition: all 0.3s ease;
    }
    .btn-success:hover {
      background: #1e7e34;
      box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
      transform: translateY(-1px);
    }

    .btn-secondary {
      border-radius: 8px;
      padding: 10px 20px;
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

<div class="container py-5">
  <a href="medical-records?action=list" class="btn btn-secondary mb-3 shadow-sm">
    <i class="fas fa-arrow-left me-2"></i> Trở về danh sách
  </a>

  <div class="card">
    <div class="card-header text-white bg-primary">
      <h3 class="mb-0"><i class="fas fa-file-medical me-2"></i> Thêm Hồ sơ Bệnh án mới</h3>
    </div>
    <div class="card-body">
      <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
          <i class="fas fa-exclamation-triangle me-2"></i> ${error}
        </div>
      </c:if>

      <form action="medical-records" method="post">
        <input type="hidden" name="action" value="add">

        <div class="mb-3">
          <label for="patient_id" class="form-label"><i class="fas fa-user-injured me-2 text-primary"></i> Chọn Bệnh nhân <span class="text-danger">*</span></label>
          <select id="patient_id" name="patient_id" class="form-select" required>
            <option value="">-- Chọn bệnh nhân --</option>
            <c:forEach var="patient" items="${patients}">
              <option value="${patient.user_id}" <c:if test="${param.patient_id == patient.user_id}">selected</c:if>>
                ID: ${patient.user_id} | ${patient.full_name}
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="mb-3">
          <label for="appointment_id" class="form-label"><i class="fas fa-calendar-alt me-2 text-primary"></i> Chọn Lịch hẹn (Tùy chọn)</label>
          <select id="appointment_id" name="appointment_id" class="form-select">
            <option value="">-- Chọn lịch hẹn --</option>
          </select>
          <div class="form-text">Lịch hẹn sẽ được tải tự động sau khi chọn bệnh nhân.</div>
        </div>

        <div class="mb-3">
          <label for="diagnosis" class="form-label"><i class="fas fa-stethoscope me-2 text-primary"></i> Chẩn đoán <span class="text-danger">*</span></label>
          <textarea id="diagnosis" name="diagnosis" class="form-control" rows="3" required placeholder="Nhập kết quả chẩn đoán...">${param.diagnosis}</textarea>
        </div>

        <div class="mb-3">
          <label for="treatment" class="form-label"><i class="fas fa-syringe me-2 text-primary"></i> Phương pháp Điều trị <span class="text-danger">*</span></label>
          <textarea id="treatment" name="treatment" class="form-control" rows="4" required placeholder="Nhập phương pháp điều trị và thuốc...">${param.treatment}</textarea>
        </div>

        <div class="mb-4">
          <label for="notes" class="form-label"><i class="fas fa-clipboard-list me-2 text-primary"></i> Ghi chú</label>
          <textarea id="notes" name="notes" class="form-control" rows="3" placeholder="Ghi chú thêm (dặn dò, tái khám...):">${param.notes}</textarea>
        </div>

        <button type="submit" class="btn btn-success btn-lg w-100">
          <i class="fas fa-save me-2"></i> Lưu Hồ sơ
        </button>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Chức năng tải lịch hẹn động
  document.addEventListener('DOMContentLoaded', function() {
    var patientSelect = document.getElementById("patient_id");
    var appointmentSelect = document.getElementById("appointment_id");
    var initialPatientId = patientSelect.value;

    // Lấy ID lịch hẹn đã chọn trước đó (khi form bị lỗi)
    var initialAppointmentId = "${param.appointment_id}" ? "${param.appointment_id}" : "";


    // Hàm tải lịch hẹn
    function loadAppointments(patientId) {
      appointmentSelect.innerHTML = '<option value="">-- Đang tải lịch hẹn... --</option>';
      if (patientId) {
        // Giả định URL 'appointments-by-patient' tồn tại và trả về JSON
        fetch('appointments-by-patient?patientId=' + patientId)
                .then(response => {
                  if (!response.ok) throw new Error('Network response was not ok');
                  return response.json();
                })
                .then(data => {
                  appointmentSelect.innerHTML = '<option value="">-- Chọn lịch hẹn (Tùy chọn) --</option>';

                  data.forEach(function(app) {
                    var option = document.createElement("option");
                    option.value = app.appointment_id;

                    // ⭐ CẬP NHẬT: Hiển thị Mã và Ngày/Giờ đã gộp ⭐
                    var displayText = `ID: ${app.appointment_id} | Mã: ${app.appointment_code || '---'} | Ngày: ${app.appointment_date || 'Không rõ'}`;
                    option.text = displayText;

                    // SỬ DỤNG BIẾN JS ĐÃ LẤY TRƯỚC ĐÓ ĐỂ CHỌN OPTION
                    if (initialAppointmentId && initialAppointmentId === app.appointment_id.toString()) {
                      option.selected = true;
                    }

                    appointmentSelect.add(option);
                  });

                  if (data.length === 0) {
                    appointmentSelect.innerHTML = '<option value="">-- Không có lịch hẹn phù hợp --</option>';
                  }

                })
                .catch(err => {
                  console.error("Lỗi khi tải lịch hẹn:", err);
                  appointmentSelect.innerHTML = '<option value="">-- Lỗi tải lịch hẹn --</option>';
                });
      } else {
        appointmentSelect.innerHTML = '<option value="">-- Chọn lịch hẹn --</option>';
      }
    }

    // Xử lý sự kiện thay đổi
    patientSelect.addEventListener("change", function() {
      // Khi thay đổi bệnh nhân, xóa ID lịch hẹn cũ đã chọn
      initialAppointmentId = "";
      loadAppointments(this.value);
    });

    // Tải lịch hẹn nếu có giá trị đã chọn ban đầu (do lỗi form)
    if (initialPatientId) {
      loadAppointments(initialPatientId);
    }
  });
</script>

</body>
</html>