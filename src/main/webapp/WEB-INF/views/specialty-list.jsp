<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Chuyên khoa</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
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
            height: auto;
        }

        .container {
            max-width: 1000px;
            width: 100%;
        }

        .card-form {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            border-left: 5px solid #007bff;
            z-index: 10;
            position: relative;
        }

        h2 {
            color: #007bff;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            transition: all .2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15);
        }

        /* Styling cho các nút */
        .btn-primary, .btn-success, .btn-secondary, .btn-info, .btn-danger {
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-primary {
            background-color: #007bff; border-color: #007bff;
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
        }
        .btn-success {
            background-color: #28a745; border-color: #28a745;
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
        }
        .btn-info {
            background-color: #17a2b8; border-color: #17a2b8;
            color: white;
        }

        /* Styling cho bảng */
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

<div class="container mt-5">
    <div class="card-form shadow">
        <h2><i class="fas fa-stethoscope me-2"></i> Quản lý Chuyên khoa</h2>

        <form class="row g-3 mb-4 align-items-end" method="get" action="${pageContext.request.contextPath}/specialties">
            <div class="col-md-4">
                <label for="searchType" class="form-label small text-muted mb-1">Loại tìm kiếm</label>
                <select id="searchType" name="searchType" class="form-select" required>
                    <option value="" ${empty param.searchType ? 'selected' : ''}>-- Chọn loại tìm kiếm --</option>
                    <option value="name" ${param.searchType eq 'name' ? 'selected' : ''}>Tên chuyên khoa</option>
                    <option value="description" ${param.searchType eq 'description' ? 'selected' : ''}>Mô tả</option>
                </select>
            </div>
            <div class="col-md-4">
                <label for="keyword" class="form-label small text-muted mb-1">Từ khóa</label>
                <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Nhập từ khóa..."
                       value="${param.keyword != null ? param.keyword : ''}"/>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-search me-1"></i> Tìm
                </button>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/specialties" class="btn btn-secondary w-100">
                    <i class="fas fa-redo me-1"></i> Reset
                </a>
            </div>
        </form>

        <div class="row mb-4 g-3">
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/specialties?action=addForm" class="btn btn-success w-100 shadow-sm">
                    <i class="fas fa-plus me-2"></i> Thêm chuyên khoa mới
                </a>
            </div>
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary w-100 shadow-sm">
                    <i class="fas fa-home me-2"></i> Quay lại Trang chủ
                </a>
            </div>
        </div>

        <div class="table-responsive">
            <c:choose>
                <c:when test="${not empty specialties}">
                    <table class="table table-striped table-hover align-middle mb-0">
                        <thead>
                        <tr>
                            <th style="width: 10%;">ID</th>
                            <th style="width: 30%;">Tên chuyên khoa</th>
                            <th style="width: 40%;">Mô tả</th>
                            <th style="width: 20%;">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="specialty" items="${specialties}">
                            <tr>
                                <td>${specialty.specialtyId}</td>
                                <td><strong class="text-primary">${specialty.name}</strong></td>
                                <td>
                                    <span class="d-inline-block text-truncate" style="max-width: 300px;">
                                            ${specialty.description}
                                    </span>
                                </td>
                                <td class="text-nowrap">
                                    <a href="${pageContext.request.contextPath}/specialties?action=editForm&id=${specialty.specialtyId}"
                                       class="btn btn-sm btn-warning me-2">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/specialties?action=delete&id=${specialty.specialtyId}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa chuyên khoa ${specialty.name} (ID: ${specialty.specialtyId}) này?');">
                                        <i class="fas fa-trash-alt"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning text-center shadow-sm" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> Không tìm thấy chuyên khoa nào.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>