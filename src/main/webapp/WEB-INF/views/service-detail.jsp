<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Dịch vụ #${service.service_id}</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background-color: #f0f8ff; /* Light Blue Background */
            margin: 0;
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: auto;
        }

        .container-fluid-custom {
            /* Tăng kích thước tối đa của container, cho phép card rộng hơn */
            max-width: 1100px;
            width: 100%;
        }

        /* Đặt lại .container để nó không bị ảnh hưởng bởi CSS global */
        .container {
            max-width: none; /* Bỏ giới hạn mặc định của Bootstrap */
            width: 100%;
            padding: 0;
            margin: 0;
        }

        .card {
            background: #ffffff;
            padding: 0;
            border-radius: 15px; /* Tăng border-radius nhẹ */
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.18); /* Tăng bóng đổ */
            border: none;
            transition: box-shadow 0.3s ease;
            z-index: 10;
            position: relative;
            /* Tăng kích thước tối đa của card */
            max-width: 100%;
            width: 100%;
        }

        .card-header {
            background-color: #007bff !important;
            border-bottom: none;
            border-radius: 15px 15px 0 0;
            padding: 25px 35px; /* Tăng padding */
        }

        h2 {
            font-weight: 700;
            margin-bottom: 0;
            font-size: 1.8rem; /* Tăng kích thước tiêu đề */
        }

        .card-body {
            padding: 35px; /* Tăng padding */
        }

        .detail-box {
            padding: 18px; /* Tăng padding */
            background-color: #f8f9fa;
            border-left: 5px solid #007bff; /* Tăng độ dày border-left */
            border-radius: 8px; /* Tăng border-radius */
            white-space: pre-wrap;
            font-size: 1rem; /* Tăng kích thước chữ */
            line-height: 1.7;
        }

        dl.row {
            margin-bottom: 0;
        }
        dl.row dt {
            font-weight: 600;
            color: #495057;
            padding-top: 5px;
        }
        dl.row dd {
            font-weight: 500;
            color: #343a40;
            margin-bottom: 15px;
        }

        /* Điều chỉnh màu sắc và độ dày của tiêu đề chi tiết */
        h5.text-primary {
            font-weight: 600;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 15px !important;
        }

        .btn-secondary {
            border-radius: 10px;
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

        /* Tinh chỉnh vị trí nút quay lại để dễ nhìn hơn */
        .back-button-container {
            width: 100%;
            max-width: 1100px; /* Phù hợp với max-width của container-fluid-custom */
            margin-bottom: 20px;
            padding: 0 15px; /* Đảm bảo padding */
        }

        /* Giữ nguyên hiệu ứng nền */
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

<div class="container-fluid-custom">
    <div class="back-button-container">
        <a href="<%= request.getContextPath() %>/services" class="btn btn-secondary shadow-sm">
            <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
        </a>
    </div>

    <c:if test="${empty service}">
        <div class="alert alert-danger text-center shadow">
            <i class="fas fa-exclamation-triangle me-2"></i> Không tìm thấy dịch vụ này.
        </div>
    </c:if>

    <c:if test="${not empty service}">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0"><i class="fas fa-briefcase me-2"></i> Chi tiết Dịch vụ #${service.service_id}</h2>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <dl class="row">
                            <dt class="col-sm-5"><i class="fas fa-tag me-2 text-primary"></i> Tên:</dt>
                            <dd class="col-sm-7 fw-bold">${service.service_name}</dd>

                            <dt class="col-sm-5"><i class="fas fa-folder me-2 text-primary"></i> Danh mục:</dt>
                            <dd class="col-sm-7">${service.category}</dd>

                            <dt class="col-sm-5"><i class="fas fa-user-friends me-2 text-primary"></i> Khách hàng mục tiêu:</dt>
                            <dd class="col-sm-7">${service.target_customer}</dd>

                            <dt class="col-sm-5"><i class="fas fa-clock me-2 text-primary"></i> Thời gian thực hiện:</dt>
                            <dd class="col-sm-7">${service.duration}</dd>
                        </dl>
                    </div>
                    <div class="col-md-6">
                        <dl class="row">
                            <dt class="col-sm-5"><i class="fas fa-money-bill-wave me-2 text-primary"></i> Giá:</dt>
                            <dd class="col-sm-7">
                                <span class="fw-bold text-danger">
                                    <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true"/> VND
                                </span>
                            </dd>

                            <dt class="col-sm-5"><i class="fas fa-cogs me-2 text-primary"></i> Kích hoạt:</dt>
                            <dd class="col-sm-7">
                                <c:choose>
                                    <c:when test="${service.is_active}">
                                        <span class="badge bg-success"><i class="fas fa-check"></i> Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger"><i class="fas fa-times"></i> Không hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </dd>

                            <dt class="col-sm-5"><i class="fas fa-calendar-plus me-2 text-primary"></i> Ngày tạo:</dt>
                            <dd class="col-sm-7">
                                <fmt:formatDate value="${createdDateJSTL}" pattern="HH:mm dd-MM-yyyy"/>
                            </dd>
                        </dl>
                    </div>
                </div>

                <hr class="mt-2 mb-4">

                <h5 class="text-primary"><i class="fas fa-file-alt me-2"></i> Mô tả:</h5>
                <div class="detail-box mb-4">${service.description}</div>

                <h5 class="text-primary"><i class="fas fa-list-ol me-2"></i> Quy trình:</h5>
                <div class="detail-box mb-4">${service.process}</div>

                <h5 class="text-primary"><i class="fas fa-flask me-2"></i> Công nghệ:</h5>
                <div class="detail-box mb-4">${service.technology}</div>

                <h5 class="text-primary"><i class="fas fa-shield-alt me-2"></i> Chính sách bảo hành:</h5>
                <div class="detail-box mb-4">${service.warranty_policy}</div>

                <div class="mt-4 text-end">
                    <c:if test="${sessionScope.userRoleId == 1}">
                        <a href="<%= request.getContextPath() %>/services?action=editForm&id=${service.service_id}"
                           class="btn btn-warning me-2">
                            <i class="fas fa-edit me-1"></i> Sửa
                        </a>

                        <a href="<%= request.getContextPath() %>/services?action=delete&id=${service.service_id}"
                           class="btn btn-danger"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ ID: ${service.service_id} này không?');">
                            <i class="fas fa-trash-alt me-1"></i> Xóa
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>