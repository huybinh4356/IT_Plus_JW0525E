<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Hồ sơ Bệnh án</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .filter-card {
            border-left-color: #17a2b8; /* Màu xanh lơ cho bộ lọc */
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
            margin-bottom: 25px;
            position: relative;
            font-size: 1.5rem;
        }

        /* Style cho Card Bệnh án */
        .record-card {
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            margin-bottom: 1rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            background: #fff;
            overflow: hidden;
        }
        .record-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border-color: #007bff;
        }

        .record-header {
            background-color: #f8f9fa;
            padding: 12px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .record-body {
            padding: 20px;
        }

        .record-info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .record-info-item i {
            width: 20px;
            color: #007bff;
            margin-right: 10px;
            padding-top: 4px;
        }

        .record-diagnosis {
            background-color: #eef7ff;
            padding: 10px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
            font-style: italic;
            margin-top: 10px;
            color: #555;
        }

        .record-actions {
            text-align: right;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        /* Form controls */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px;
        }
        .btn {
            border-radius: 8px;
            font-weight: 500;
        }

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

    <h1>
        <i class="fas fa-file-medical text-primary me-2"></i>
        <c:choose>
            <c:when test="${sessionScope.userRoleId + 0 eq 3}">Hồ Sơ Của Tôi</c:when>
            <c:when test="${not empty patientId}">Hồ Sơ Bệnh Nhân: ${patientId}</c:when>
            <c:otherwise>Quản Lý Hồ Sơ Bệnh Án</c:otherwise>
        </c:choose>
    </h1>

    <div class="mb-3">
        <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
        </a>
    </div>

    <div class="row g-4">

        <div class="col-lg-8">
            <div class="content-card">

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0 text-start"><i class="fas fa-list-ul me-2"></i> Danh sách hồ sơ</h2>
                    <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
                        <a href="medical-records?action=showAddForm" class="btn btn-success btn-sm shadow-sm">
                            <i class="fas fa-plus me-2"></i> Tạo Hồ Sơ Mới
                        </a>
                    </c:if>
                </div>

                <c:choose>
                    <c:when test="${empty records}">
                        <div class="alert alert-info text-center py-4">
                            <i class="fas fa-folder-open fa-3x mb-3 text-muted"></i><br>
                            Chưa có hồ sơ bệnh án nào được tìm thấy.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="record" items="${records}">
                            <div class="record-card">
                                <div class="record-header">
                                    <span class="fw-bold text-primary">#HS-${record.record_id}</span>
                                    <small class="text-muted">
                                        <i class="far fa-clock me-1"></i>
                                        <c:if test="${not empty record.createdAtTimestamp}">
                                            <fmt:formatDate value="${record.createdAtTimestamp}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:if>
                                        <c:if test="${empty record.createdAtTimestamp}">N/A</c:if>
                                    </small>
                                </div>

                                <div class="record-body">
                                    <div class="record-info-item">
                                        <i class="fas fa-user-injured"></i>
                                        <span>
                                            <strong>Bệnh nhân:</strong>
                                            <c:if test="${not empty record.patient_id}">
                                                ${record.patient_id.full_name} (ID: ${record.patient_id.user_id})
                                            </c:if>
                                        </span>
                                    </div>

                                    <div class="record-info-item">
                                        <i class="fas fa-calendar-check"></i>
                                        <span>
                                            <strong>Lịch hẹn liên quan:</strong>
                                            <c:if test="${not empty record.appointment_id}">
                                                <span class="badge bg-info text-dark">#LH-${record.appointment_id.appointment_id}</span>
                                            </c:if>
                                            <c:if test="${empty record.appointment_id}">
                                                <span class="text-muted">Không có</span>
                                            </c:if>
                                        </span>
                                    </div>

                                    <div class="record-diagnosis">
                                        <strong><i class="fas fa-stethoscope me-1"></i> Chẩn đoán:</strong><br>
                                            ${record.diagnosis}
                                    </div>

                                    <div class="record-actions">
                                        <a href="medical-records?action=detail&id=${record.record_id}" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-info-circle me-1"></i> Xem chi tiết
                                        </a>

                                        <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
                                            <a href="medical-records?action=edit&id=${record.record_id}" class="btn btn-outline-warning btn-sm ms-1">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <div class="col-lg-4">
            <div class="content-card filter-card">
                <h2 class="text-info"><i class="fas fa-search me-2"></i> Tra cứu</h2>
                <p class="small text-muted">Tìm kiếm hồ sơ bệnh án nhanh chóng.</p>
                <hr>

                <form action="medical-records" method="get">
                    <input type="hidden" name="action" value="list">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Từ khóa</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control" placeholder="Tên bệnh nhân, chẩn đoán..." value="${param.keyword}">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Lọc theo ngày</label>
                        <input type="date" name="date" class="form-control" value="${param.date}">
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-info text-white">
                            <i class="fas fa-filter me-2"></i> Lọc kết quả
                        </button>
                        <a href="medical-records?action=list" class="btn btn-outline-secondary">
                            <i class="fas fa-sync-alt me-2"></i> Làm mới
                        </a>
                    </div>
                </form>

                <div class="mt-4 p-3 bg-light rounded border">
                    <h6 class="fw-bold text-muted mb-2"><i class="fas fa-chart-pie me-2"></i> Thống kê nhanh</h6>
                    <ul class="list-unstyled small mb-0">
                        <li class="d-flex justify-content-between mb-1">
                            <span>Tổng số hồ sơ:</span>
                            <span class="fw-bold">${records.size()}</span>
                        </li>
                        <li class="d-flex justify-content-between">
                            <span>Ngày hôm nay:</span>
                            <span class="fw-bold text-success">--</span>
                        </li>
                    </ul>
                </div>

            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>