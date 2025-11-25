<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Dịch Vụ</title>
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

        /* (Giữ nguyên CSS cũ) */
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

        h1 { color: #007bff; font-weight: 700; text-align: center; margin-bottom: 30px; position: relative; }
        h1::after { content: ''; position: absolute; bottom: -5px; left: 50%; transform: translateX(-50%); width: 100px; height: 3px; background-color: #007bff; border-radius: 2px; }
        h2 { color: #007bff; font-weight: 700; margin-bottom: 25px; position: relative; font-size: 1.75rem; }
        label { font-weight: 600; color: #495057; margin-bottom: 5px; display: block; }
        .form-control, .form-select { border-radius: 8px; padding: 10px 15px; border: 1px solid #ced4da; transition: all 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: #007bff; box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.15); }
        .btn-primary, .btn-success { border: none; border-radius: 8px; padding: 10px 20px; font-weight: 600; transition: all 0.3s ease; }
        .btn-primary { background: #007bff; box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3); }
        .btn-primary:hover { background: #0056b3; transform: translateY(-1px); }
        .btn-success { background: #28a745; box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3); }
        .btn-success:hover { background: #1e7e34; transform: translateY(-1px); }
        .btn-info, .btn-warning, .btn-danger { border-radius: 6px; font-weight: 500; }

        .service-card-list {
            display: flex; flex-direction: row; justify-content: space-between; align-items: flex-start;
            border: 1px solid #e0e0e0; border-radius: 12px; padding: 20px; margin-bottom: 1rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); transition: all 0.3s ease;
        }
        .service-card-list:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); }
        .service-card-list-info { flex: 1; padding-right: 15px; }
        .service-card-list-actions { text-align: right; min-width: 140px; display: flex; flex-direction: column; gap: 8px; align-items: flex-end;} /* Sửa lại layout action */
        .service-card-list-info h5 { color: #007bff; font-weight: 600; margin-bottom: 5px; }
        .service-price { font-size: 1.2rem; font-weight: 600; color: #198754; margin-top: 10px; }

        /* CSS cho Featured Card */
        .service-card-featured {
            text-align: center; padding: 20px; min-height: 250px; display: flex; flex-direction: column;
            justify-content: flex-start; align-items: center; border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,.07); transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out; background-color: #ffffff;
        }
        .service-card-featured:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,.15); }
        .service-card-featured .service-img { width: 100%; max-width: 100%; height: 150px; object-fit: cover; display: block; margin-bottom: 15px; border-radius: 8px; }

        /* Background shapes */
        .background-shape-1, .background-shape-2 { position: fixed; border-radius: 50%; z-index: -1; opacity: 0.5; filter: blur(100px); animation: floatShape 10s ease-in-out infinite alternate; }
        .background-shape-1 { top: -100px; left: -100px; width: 400px; height: 400px; background: radial-gradient(circle, rgba(173, 216, 230, 0.3), rgba(173, 216, 230, 0)); }
        .background-shape-2 { bottom: -150px; right: -150px; width: 500px; height: 500px; background: radial-gradient(circle, rgba(135, 206, 235, 0.25), rgba(135, 206, 235, 0)); animation-direction: alternate-reverse; }
        @keyframes floatShape { from { transform: translate(0, 0); } to { transform: translate(20px, 20px); } }
    </style>
</head>
<body>
<div class="background-shape-1"></div>
<div class="background-shape-2"></div>

<div class="container-xl my-5">

    <h1>Danh Sách Dịch Vụ</h1>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i> Quay lại Trang chủ
        </a>
    </div>

    <div class="row g-4">

        <div class="col-lg-8">
            <div class="content-card">

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0 text-start">
                        <i class="fas fa-list-alt me-2"></i> Dịch Vụ Của Chúng Tôi
                    </h2>
                    <c:if test="${sessionScope.userRoleId == 1}">
                        <a href="${pageContext.request.contextPath}/services?action=addForm" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus me-2"></i> Thêm Dịch Vụ
                        </a>
                    </c:if>
                </div>

                <div class="search-form mb-4 p-3 bg-light rounded border">
                    <form action="${pageContext.request.contextPath}/services" method="get" class="row g-2 align-items-end">
                        <input type="hidden" name="action" value="search"/>
                        <div class="col-md-4">
                            <label for="searchType" class="form-label small fw-bold">Tìm theo</label>
                            <select name="searchType" id="searchType" class="form-select">
                                <option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>Tên</option>
                                <option value="category" <c:if test="${param.searchType eq 'category'}">selected</c:if>>Danh mục</option>
                                <option value="technology" <c:if test="${param.searchType eq 'technology'}">selected</c:if>>Công nghệ</option>
                                <option value="price" <c:if test="${param.searchType eq 'price'}">selected</c:if>>Giá</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label for="keyword" class="form-label small fw-bold">Từ khóa</label>
                            <input type="text" name="keyword" id="keyword" class="form-control" placeholder="Nhập từ khóa..." value="${param.keyword}"/>
                        </div>
                        <div class="col-md-3 d-grid">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-search me-1"></i> Tìm kiếm
                            </button>
                        </div>
                    </form>
                </div>

                <hr class="my-4">

                <c:choose>
                    <c:when test="${empty services}">
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i> Không tìm thấy dịch vụ nào khớp với tiêu chí.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="s" items="${services}">
                            <div class="service-card-list shadow-sm">
                                <div class="service-card-list-info">
                                    <h5 class="mb-1">${s.service_name}</h5>
                                    <p class="mb-2">
                                        <span class="badge bg-secondary me-1">${s.category}</span>
                                        <span class="badge bg-info text-dark">${s.technology}</span>
                                    </p>
                                    <div class="service-price">
                                        <fmt:formatNumber value="${s.price}" type="number" groupingUsed="true"/> VND
                                    </div>
                                </div>
                                <div class="service-card-list-actions">

                                    <c:choose>
                                        <c:when test="${s.is_active}">
                                            <span class="badge bg-success mb-1"><i class="fas fa-check"></i> Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger mb-1"><i class="fas fa-times"></i> Ngừng</span>
                                        </c:otherwise>
                                    </c:choose>

                                    <button type="button" class="btn btn-info btn-sm w-100 text-white"
                                            data-bs-toggle="modal" data-bs-target="#detailModal${s.service_id}">
                                        <i class="fas fa-eye me-1"></i> Xem
                                    </button>

                                    <c:if test="${not empty sessionScope.user}">
                                        <form action="${pageContext.request.contextPath}/wishlist" method="post" class="w-100">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="serviceId" value="${s.service_id}">
                                            <input type="hidden" name="notes" value="Thêm từ danh sách dịch vụ">
                                            <button type="submit" class="btn btn-outline-danger btn-sm w-100" title="Thêm vào danh sách yêu thích">
                                                <i class="fas fa-heart me-1"></i> Yêu thích
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${empty sessionScope.user}">
                                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-secondary btn-sm w-100" title="Đăng nhập để lưu">
                                            <i class="far fa-heart me-1"></i> Yêu thích
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.userRoleId == 1}">
                                        <div class="d-flex w-100 gap-1">
                                            <a href="${pageContext.request.contextPath}/services?action=edit&id=${s.service_id}" class="btn btn-warning btn-sm flex-grow-1"><i class="fas fa-edit"></i></a>
                                            <a href="${pageContext.request.contextPath}/services?action=delete&id=${s.service_id}" class="btn btn-danger btn-sm flex-grow-1" onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ ${s.service_name}?');"><i class="fas fa-trash-alt"></i></a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <div class="col-lg-4">
            <div class="content-card" style="border-left-color: #ffc107;">
                <h2 class="mb-0 text-start" style="font-size: 1.7rem; color: #ffc107;">
                    <i class="fas fa-star me-2"></i> Dịch vụ nổi bật
                </h2>
                <hr class="my-4">

                <c:url var="service1DetailUrl" value="/service_demo_list"><c:param name="action" value="detail"/><c:param name="id" value="1"/></c:url>
                <a href="${service1DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card-featured mb-3">
                        <img src="${pageContext.request.contextPath}/assets/images/img_5.png" alt="Khám tổng quát" class="service-img">
                        <h5 class="fw-bold">Khám tổng quát</h5>
                        <p class="text-muted small">Kiểm tra, chụp X-quang phát hiện sớm bệnh lý.</p>
                    </div>
                </a>

                <c:url var="service5DetailUrl" value="/service_demo_list"><c:param name="action" value="detail"/><c:param name="id" value="5"/></c:url>
                <a href="${service5DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card-featured mb-3">
                        <img src="${pageContext.request.contextPath}/assets/images/img_8.png" alt="Implant" class="service-img">
                        <h5 class="fw-bold">Cấy ghép Implant</h5>
                        <p class="text-muted small">Phục hình răng mất bằng trụ Implant Thụy Sĩ.</p>
                    </div>
                </a>

                <c:url var="service4DetailUrl" value="/service_demo_list"><c:param name="action" value="detail"/><c:param name="id" value="4"/></c:url>
                <a href="${service4DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card-featured mb-3">
                        <img src="${pageContext.request.contextPath}/assets/images/img_7.png" alt="Tẩy Trắng" class="service-img">
                        <h5 class="fw-bold">Tẩy Trắng Răng</h5>
                        <p class="text-muted small">Công nghệ plasma Beyond, răng trắng sáng an toàn.</p>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>

<c:forEach var="s" items="${services}">
    <div class="modal fade" id="detailModal${s.service_id}" tabindex="-1" aria-labelledby="detailModalLabel${s.service_id}" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailModalLabel${s.service_id}">Chi Tiết Dịch Vụ: ${s.service_name}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <dl class="row">
                        <dt class="col-sm-4 text-muted">Mã ID:</dt><dd class="col-sm-8">${s.service_id}</dd>
                        <dt class="col-sm-4 text-muted">Tên Dịch Vụ:</dt><dd class="col-sm-8">${s.service_name}</dd>
                        <dt class="col-sm-4 text-muted">Danh mục:</dt><dd class="col-sm-8"><span class="badge bg-secondary">${s.category}</span></dd>
                        <dt class="col-sm-4 text-muted">Công nghệ:</dt><dd class="col-sm-8">${s.technology}</dd>
                        <dt class="col-sm-4 text-muted">Giá:</dt><dd class="col-sm-8"><fmt:formatNumber value="${s.price}" type="number" groupingUsed="true"/> VND</dd>
                        <dt class="col-sm-4 text-muted">Trạng thái:</dt>
                        <dd class="col-sm-8">
                            <c:choose>
                                <c:when test="${s.is_active}"><span class="badge bg-success"><i class="fas fa-check"></i> Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-danger"><i class="fas fa-times"></i> Ngừng</span></c:otherwise>
                            </c:choose>
                        </dd>
                        <dt class="col-sm-4 text-muted">Mô Tả:</dt><dd class="col-sm-8"><p class="border p-2 rounded bg-light">${not empty s.description ? s.description : "Chưa có mô tả."}</p></dd>
                    </dl>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times"></i> Đóng</button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>