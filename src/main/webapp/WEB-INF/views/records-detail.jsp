<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Hồ sơ Bệnh án</title>
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

        .card {
            background: #ffffff;
            padding: 0;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            border: none;
            transition: box-shadow 0.3s ease;
            z-index: 10;
            position: relative;
            max-width: 900px;
            width: 100%;
        }

        .card-header {
            background-color: #007bff !important;
            border-bottom: none;
            border-radius: 12px 12px 0 0;
            padding: 20px 30px;
        }

        h3 {
            font-weight: 700;
            margin-bottom: 0;
        }

        .card-body {
            padding: 30px;
        }

        .info-box {
            padding: 15px;
            background-color: #e6f7ff;
            border-radius: 8px;
            border: 1px solid #b3d9ff;
            font-size: 0.95rem;
        }

        .detail-box {
            padding: 15px;
            background-color: #f8f9fa;
            border-left: 4px solid #007bff;
            border-radius: 6px;
            white-space: pre-wrap;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        h5 {
            color: #007bff;
            font-weight: 600;
            margin-top: 15px;
            margin-bottom: 10px;
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

        .btn-warning {
            border-radius: 8px;
            font-weight: 600;
        }

        .btn-danger {
            border-radius: 8px;
            font-weight: 600;
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
    <a href="medical-records?action=list" class="btn btn-secondary mb-4 shadow-sm">
        <i class="fas fa-arrow-left me-2"></i> Trở về danh sách
    </a>

    <c:if test="${empty record}">
        <div class="alert alert-danger text-center shadow">
            <i class="fas fa-exclamation-triangle me-2"></i> Không tìm thấy Hồ sơ Bệnh án này.
        </div>
    </c:if>

    <c:if test="${not empty record}">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3 class="mb-0"><i class="fas fa-file-medical me-2"></i> Hồ sơ Bệnh án #${record.record_id}</h3>
            </div>
            <div class="card-body">

                <div class="row mb-4 g-3">
                    <div class="col-md-6">
                        <div class="info-box">
                            <i class="fas fa-user-injured me-2 text-primary"></i>
                            <strong class="text-secondary">Bệnh nhân:</strong>
                            <p class="mb-0 fw-bold text-dark">
                                <c:if test="${not empty record.patient_id}">
                                    ${record.patient_id.full_name} (ID: ${record.patient_id.user_id})
                                </c:if>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-box">
                            <i class="fas fa-calendar-alt me-2 text-primary"></i>
                            <strong class="text-secondary">Lịch hẹn liên kết:</strong>
                            <p class="mb-0">
                                <c:if test="${not empty record.appointment_id}">
                                    Lịch hẹn ID: <span class="fw-bold text-dark">${record.appointment_id.appointment_id}</span>
                                </c:if>
                                <c:if test="${empty record.appointment_id}">
                                    <span class="text-muted">(Không có lịch hẹn)</span>
                                </c:if>
                            </p>
                        </div>
                    </div>
                </div>

                <hr class="mb-4">

                <dl>
                    <h5 class="text-primary"><i class="fas fa-stethoscope me-2"></i> Chẩn đoán (Diagnosis):</h5>
                    <dd class="detail-box mb-4">${record.diagnosis}</dd>

                    <h5 class="text-primary"><i class="fas fa-syringe me-2"></i> Phương pháp Điều trị (Treatment):</h5>
                    <dd class="detail-box mb-4">${record.treatment}</dd>

                    <h5 class="text-primary"><i class="fas fa-clipboard-list me-2"></i> Ghi chú (Notes):</h5>
                    <dd class="detail-box mb-4">
                        <c:if test="${not empty record.notes}">${record.notes}</c:if>
                        <c:if test="${empty record.notes}"><span class="text-muted fst-italic">Không có ghi chú.</span></c:if>
                    </dd>
                </dl>

                <hr>

                <p class="small text-muted mt-3 mb-4">
                    <i class="fas fa-clock me-1"></i> **Ngày tạo:** <fmt:formatDate value="${record.createdAtTimestamp}" pattern="HH:mm dd-MM-yyyy"/>
                </p>

                    <%-- Nút hành động --%>
                <c:if test="${sessionScope.userRoleId == '1' || sessionScope.userRoleId == '2'}">
                    <a href="medical-records?action=showEditForm&id=${record.record_id}" class="btn btn-warning me-2">
                        <i class="fas fa-edit me-1"></i> Chỉnh sửa
                    </a>

                    <form action="medical-records" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa hồ sơ ${record.record_id} này? Hành động này không thể hoàn tác.');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${record.record_id}">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash-alt me-1"></i> Xóa
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>