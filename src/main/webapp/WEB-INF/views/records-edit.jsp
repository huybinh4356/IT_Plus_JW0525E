<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Hồ sơ Bệnh án</title>
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
            padding: 0;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            border: none;
            transition: box-shadow 0.3s ease;
            z-index: 10;
            position: relative;
        }
        .card:hover {
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            background-color: #ffc107 !important;
            border-bottom: none;
            border-radius: 12px 12px 0 0;
            padding: 20px 30px;
        }

        h3 {
            font-weight: 700;
            margin-bottom: 0;
            color: #333;
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

        .btn-primary {
            background: #007bff;
            border: none;
            border-radius: 8px;
            padding: 12px 25px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #0056b3;
            box-shadow: 0 6px 15px rgba(0, 123, 255, 0.4);
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
    <a href="medical-records?action=detail&id=${record.record_id}" class="btn btn-secondary mb-4 shadow-sm">
        <i class="fas fa-arrow-left me-2"></i> Trở về chi tiết
    </a>

    <c:choose>
        <c:when test="${sessionScope.userRoleId == '1' || sessionScope.userRoleId == '2'}">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark">
                    <h3 class="mb-0"><i class="fas fa-edit me-2"></i> Chỉnh sửa Hồ sơ Bệnh án #${record.record_id}</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                        </div>
                    </c:if>

                    <form action="medical-records" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="record_id" value="${record.record_id}">

                            <%-- Giữ lại Patient ID dưới dạng hidden input để gửi đi khi submit (ReadOnly) --%>
                        <input type="hidden" name="patient_id" value="${record.patient_id.user_id}">

                        <p class="mb-4 text-muted">Bệnh nhân: **${record.patient_id.full_name} (ID: ${record.patient_id.user_id})**</p>

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="patient_id_display" class="form-label"><i class="fas fa-user-injured me-2 text-primary"></i> Bệnh nhân</label>
                                <input type="text" class="form-control" id="patient_id_display" value="${record.patient_id.full_name}" readonly>

                                    <%-- Lưu ID lịch hẹn ban đầu (hoặc ID đã chọn sau postback) vào hidden input để JS lấy --%>
                                <input type="hidden" id="initial_appointment_id"
                                       value="<c:choose><c:when test="${not empty param.appointment_id}">${param.appointment_id}</c:when><c:when test="${not empty record.appointment_id}">${record.appointment_id.appointment_id}</c:when><c:otherwise></c:otherwise></c:choose>">
                            </div>

                            <div class="col-md-12 mb-3">
                                <label for="appointment_id" class="form-label"><i class="fas fa-calendar-alt me-2 text-primary"></i> Lịch hẹn liên quan (Tùy chọn)</label>
                                <select id="appointment_id" name="appointment_id" class="form-select">
                                    <option value="">-- Đang tải lịch hẹn... --</option>

                                        <%-- Option hiện tại (chỉ là placeholder, sẽ bị AJAX ghi đè) --%>
                                    <c:if test="${not empty record.appointment_id and empty param.appointment_id}">
                                        <option value="${record.appointment_id.appointment_id}" selected>
                                            [Hiện tại] ID: ${record.appointment_id.appointment_id}
                                        </option>
                                    </c:if>
                                </select>
                                <div class="form-text">Các lịch hẹn của bệnh nhân sẽ được tải tự động.</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="diagnosis" class="form-label"><i class="fas fa-stethoscope me-2 text-primary"></i> Chẩn đoán <span class="text-danger">*</span></label>
                                <%-- Dùng param.diagnosis để giữ lại giá trị nếu có lỗi form --%>
                            <textarea id="diagnosis" name="diagnosis" class="form-control" rows="3" required>${not empty param.diagnosis ? param.diagnosis : record.diagnosis}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="treatment" class="form-label"><i class="fas fa-syringe me-2 text-primary"></i> Phương pháp Điều trị <span class="text-danger">*</span></label>
                                <%-- Dùng param.treatment để giữ lại giá trị nếu có lỗi form --%>
                            <textarea id="treatment" name="treatment" class="form-control" rows="4" required>${not empty param.treatment ? param.treatment : record.treatment}</textarea>
                        </div>

                        <div class="mb-4">
                            <label for="notes" class="form-label"><i class="fas fa-clipboard-list me-2 text-primary"></i> Ghi chú</label>
                                <%-- Dùng param.notes để giữ lại giá trị nếu có lỗi form --%>
                            <textarea id="notes" name="notes" class="form-control" rows="3">${not empty param.notes ? param.notes : record.notes}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100">
                            <i class="fas fa-sync-alt me-2"></i> Cập nhật Hồ sơ
                        </button>
                    </form>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger shadow">
                <h4><i class="fas fa-ban me-2"></i> Truy cập bị từ chối!</h4>
                <p>Chức năng chỉnh sửa hồ sơ bệnh án chỉ dành cho Bác sĩ hoặc Quản trị viên.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%-- KHỐI JAVASCRIPT/AJAX TẢI LỊCH HẸN ĐỘNG --%>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Patient ID cố định cho trang EDIT
        var patientId = document.querySelector('input[name="patient_id"]').value;
        var appointmentSelect = document.getElementById("appointment_id");

        // Lấy ID lịch hẹn đã chọn ban đầu (từ hidden input đã được tính toán bằng JSTL)
        var initialAppointmentId = document.getElementById("initial_appointment_id").value;

        // Hàm tải lịch hẹn
        function loadAppointments(pId) {
            appointmentSelect.innerHTML = '<option value="">-- Đang tải lịch hẹn... --</option>';
            if (pId) {
                fetch('appointments-by-patient?patientId=' + pId)
                    .then(response => {
                        if (!response.ok) throw new Error('Network response was not ok');
                        return response.json();
                    })
                    .then(data => {
                        appointmentSelect.innerHTML = '<option value="">-- Chọn lịch hẹn (Tùy chọn) --</option>';
                        let foundInitial = false;

                        data.forEach(function(app) {
                            var option = document.createElement("option");
                            option.value = app.appointment_id;

                            // ⭐ CẬP NHẬT: Hiển thị Mã và Ngày/Giờ đã gộp ⭐
                            var displayText = `ID: ${app.appointment_id} | Mã: ${app.appointment_code || '---'} | Ngày: ${app.appointment_date || 'Không rõ'}`;
                            option.text = displayText;

                            if (initialAppointmentId && initialAppointmentId === app.appointment_id.toString()) {
                                option.selected = true;
                                foundInitial = true;
                            }

                            appointmentSelect.add(option);
                        });

                        if (data.length === 0) {
                            appointmentSelect.innerHTML = '<option value="">-- Không có lịch hẹn phù hợp --</option>';
                        }

                        // Nếu ID ban đầu không được tìm thấy trong danh sách mới
                        if (initialAppointmentId && !foundInitial && initialAppointmentId !== "") {
                            // Thêm option cũ vào và chọn nó
                            let currentOption = document.createElement("option");
                            currentOption.value = initialAppointmentId;
                            currentOption.text = `[ID Cũ: ${initialAppointmentId}] - Vui lòng chọn lại`;
                            currentOption.selected = true;
                            appointmentSelect.add(currentOption);
                        }
                    })
                    .catch(err => {
                        console.error("Lỗi khi tải lịch hẹn:", err);
                        appointmentSelect.innerHTML = '<option value="">-- Lỗi tải lịch hẹn --</option>';
                    });
            } else {
                appointmentSelect.innerHTML = '<option value="">-- Chọn lịch hẹn (Tùy chọn) --</option>';
            }
        }

        // Tải lịch hẹn ngay khi trang được nạp
        if (patientId) {
            loadAppointments(patientId);
        }
    });
</script>

</body>
</html>