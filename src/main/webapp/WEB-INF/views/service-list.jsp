<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách dịch vụ</title>
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
            max-width: 1200px;
            width: 100%;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border: none;
            z-index: 10;
            position: relative;
        }

        h2 {
            color: #007bff;
            font-weight: 700;
            position: relative;
            margin-bottom: 25px;
        }

        /* Form tìm kiếm */
        .search-card {
            border-left: 5px solid #ffc107;
            padding: 25px;
        }
        .form-select, .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
        }
        .btn-success {
            background: #28a745;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
        }

        /* Bảng danh sách */
        .table-card {
            border-left: 5px solid #007bff;
            padding: 25px;
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
            vertical-align: middle;
        }

        .btn-primary {
            background: #007bff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
        }

        /* Style cho nút Home mới */
        .btn-home {
            background-color: #6c757d; /* Màu xám */
            border-color: #6c757d;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            padding: 10px 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }
        .btn-home:hover {
            background-color: #5a6268;
            border-color: #545b62;
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

    <div class="card mb-4 shadow search-card">
        <h2 class="mb-3"><i class="fas fa-search me-2"></i> Tìm kiếm dịch vụ</h2>
        <form action="${pageContext.request.contextPath}/services" method="get" class="d-flex align-items-center">
            <input type="hidden" name="action" value="search"/>
            <select name="searchType" class="form-select w-auto me-2" style="min-width: 150px;">
                <option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>Tên</option>
                <option value="category" <c:if test="${param.searchType eq 'category'}">selected</c:if>>Danh mục</option>
                <option value="technology" <c:if test="${param.searchType eq 'technology'}">selected</c:if>>Công nghệ</option>
                <option value="price" <c:if test="${param.searchType eq 'price'}">selected</c:if>>Giá</option>
            </select>
            <input type="text" name="keyword" class="form-control me-2" placeholder="Nhập từ khóa..." value="${param.keyword}"/>
            <button type="submit" class="btn btn-success">
                <i class="fas fa-search me-1"></i> Tìm kiếm
            </button>
        </form>
    </div>

    <div class="card shadow table-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0"><i class="fas fa-list-alt me-2"></i> Danh sách dịch vụ</h2>

            <div class="d-flex">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-home shadow-sm me-2">
                    <i class="fas fa-home me-2"></i> Về Trang chủ
                </a>

                <%-- Bắt đầu phần kiểm tra role_id --%>
                <c:if test="${sessionScope.userRoleId == 1}">
                    <a href="${pageContext.request.contextPath}/services?action=addForm" class="btn btn-primary shadow-sm">
                        <i class="fas fa-plus me-2"></i> Thêm dịch vụ mới
                    </a>
                </c:if>
                <%-- Kết thúc phần kiểm tra role_id --%>

            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0 align-middle">
                <thead>
                <tr>
                    <th style="width: 5%;">ID</th>
                    <th style="width: 25%;">Tên dịch vụ</th>
                    <th style="width: 15%;">Danh mục</th>
                    <th style="width: 20%;">Công nghệ</th>
                    <th style="width: 10%;">Giá</th>
                    <th style="width: 10%;">Trạng thái</th>
                    <th style="width: 15%;">Chi tiết</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${services}">
                    <tr>
                        <td>${s.service_id}</td>
                        <td>${s.service_name}</td>
                        <td><span class="badge bg-secondary">${s.category}</span></td>
                        <td>${s.technology}</td>
                        <td>
                            <fmt:formatNumber value="${s.price}" type="number" groupingUsed="true"/> VND
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${s.is_active}">
                                    <span class="badge bg-success"><i class="fas fa-check"></i> Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger"><i class="fas fa-times"></i> Ngừng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/services?action=detail&id=${s.service_id}"
                               class="btn btn-sm btn-info">
                                <i class="fas fa-info-circle me-1"></i> Xem
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty services}">
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            <i class="fas fa-exclamation-circle me-2"></i> Không tìm thấy dịch vụ nào.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>