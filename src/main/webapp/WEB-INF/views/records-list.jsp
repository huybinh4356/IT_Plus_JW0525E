<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Hồ sơ Bệnh án</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        /* ... (Phần CSS giữ nguyên) ... */
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

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #007bff;
            z-index: 10;
            position: relative;
        }

        h3 {
            color: #007bff;
            font-weight: 700;
            margin-bottom: 25px;
            position: relative;
        }
        h3::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 70px;
            height: 3px;
            background-color: #007bff;
            border-radius: 2px;
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
            font-size: 0.95rem;
        }

        /* Nút thêm mới */
        .btn-success {
            background: #28a745;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: #1e7e34;
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
            transform: translateY(-1px);
        }

        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
            color: white;
            border-radius: 6px;
            padding: 5px 12px;
            font-size: 0.85rem;
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

    <h3 class="mb-4">
        <i class="fas fa-notes-medical me-2"></i>
        <%-- LOGIC HIỂN THỊ TIÊU ĐỀ DỰA TRÊN ROLE ID --%>
        <c:choose>
            <%-- Nếu là Bệnh nhân (Role ID 3) --%>
            <c:when test="${sessionScope.userRoleId + 0 eq 3}">
                Hồ sơ Bệnh án của tôi
            </c:when>
            <%-- Nếu là Admin/Bác sĩ (Role ID 1, 2) hoặc đang xem bệnh nhân cụ thể --%>
            <c:when test="${not empty patientId}">
                Lịch sử Bệnh án của Bệnh nhân ID: ${patientId}
            </c:when>
            <c:otherwise>
                Tất cả Hồ sơ Bệnh án
            </c:otherwise>
        </c:choose>
    </h3>

    <div class="d-flex justify-content-between mb-4">
        <a href="<c:url value='/home'/>" class="btn btn-secondary">
            <i class="fas fa-home me-2"></i> Trang chủ
        </a>

        <%-- CHỈ CHO PHÉP ADMIN/BÁC SĨ THÊM HỒ SƠ --%>
        <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
            <a href="medical-records?action=showAddForm" class="btn btn-success shadow">
                <i class="fas fa-plus me-2"></i> Thêm Hồ sơ mới
            </a>
        </c:if>
    </div>

    <div class="card shadow">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0 align-middle">
                    <thead>
                    <tr>
                        <th style="width: 5%;">ID</th>
                        <th style="width: 20%;">Bệnh nhân</th>
                        <th style="width: 35%;">Chẩn đoán</th>
                        <th style="width: 10%;">Lịch hẹn ID</th>
                        <th style="width: 15%;">Ngày tạo</th>
                        <th style="width: 15%;">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="record" items="${records}">
                        <tr>
                            <td>${record.record_id}</td>
                            <td>
                                <c:if test="${not empty record.patient_id}">
                                    **${record.patient_id.full_name}** <br> (ID: ${record.patient_id.user_id})
                                </c:if>
                            </td>
                            <td>
                                <span class="d-inline-block text-truncate" style="max-width: 250px;">
                                        ${record.diagnosis}
                                </span>
                            </td>
                            <td>
                                <c:if test="${not empty record.appointment_id}">
                                    <span class="badge bg-primary">${record.appointment_id.appointment_id}</span>
                                </c:if>
                                <c:if test="${empty record.appointment_id}">
                                    <span class="text-muted small">N/A</span>
                                </c:if>
                            </td>
                            <td>
                                    <%-- ĐÃ SỬA LỖI ĐỊNH DẠNG NGÀY THÁNG --%>
                                <c:if test="${not empty record.createdAtTimestamp}">
                                    <fmt:formatDate value="${record.createdAtTimestamp}" pattern="dd-MM-yyyy HH:mm"/>
                                </c:if>
                                <c:if test="${empty record.createdAtTimestamp}">
                                    <span class="text-muted small">Không xác định</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="medical-records?action=detail&id=${record.record_id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-info-circle me-1"></i> Xem chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty records}">
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="fas fa-exclamation-circle me-2"></i> Không tìm thấy hồ sơ nào.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>