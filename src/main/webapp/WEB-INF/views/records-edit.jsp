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
            background-color: #ffc107 !important; /* Màu vàng (Warning) cho header */
            border-bottom: none;
            border-radius: 12px 12px 0 0;
            padding: 20px 30px;
        }

        h3 {
            font-weight: 700;
            margin-bottom: 0;
            color: #333; /* Màu chữ đậm cho dễ nhìn */
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

        /* Dùng màu xanh dương primary cho nút Cập nhật (đồng bộ với Lưu) */
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

                        <p class="mb-4 text-muted">Bệnh nhân: **${record.patient_id.full_name}**</p>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="patient_id" class="form-label"><i class="fas fa-user-injured me-2 text-primary"></i> ID Bệnh nhân <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="patient_id" name="patient_id" required value="${record.patient_id.user_id}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="appointment_id" class="form-label"><i class="fas fa-calendar-alt me-2 text-primary"></i> ID Lịch hẹn (Tùy chọn)</label>
                                <input type="number" class="form-control" id="appointment_id" name="appointment_id" placeholder="ID Lịch hẹn nếu có"
                                       value="<c:if test="${not empty record.appointment_id}">${record.appointment_id.appointment_id}</c:if>">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="diagnosis" class="form-label"><i class="fas fa-stethoscope me-2 text-primary"></i> Chẩn đoán <span class="text-danger">*</span></label>
                            <textarea id="diagnosis" name="diagnosis" class="form-control" rows="3" required>${record.diagnosis}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="treatment" class="form-label"><i class="fas fa-syringe me-2 text-primary"></i> Phương pháp Điều trị <span class="text-danger">*</span></label>
                            <textarea id="treatment" name="treatment" class="form-control" rows="4" required>${record.treatment}</textarea>
                        </div>

                        <div class="mb-4">
                            <label for="notes" class="form-label"><i class="fas fa-clipboard-list me-2 text-primary"></i> Ghi chú</label>
                            <textarea id="notes" name="notes" class="form-control" rows="3">${record.notes}</textarea>
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
</body>
</html>