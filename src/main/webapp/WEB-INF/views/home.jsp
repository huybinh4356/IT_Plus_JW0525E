<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DreamTooth - Chăm sóc nụ cười của bạn từ hôm nay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background-color: #ffffff;
            font-family: 'Inter', sans-serif;
            font-size: 1.1rem;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: auto;
        }

        .nav-link:hover { color: #007bff !important; }
        .custom-navbar {
            padding: 1rem 0;
            background-color: #ffffff !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand-large {
            font-size: 1.75rem !important;
            font-weight: 700;
        }
        .navbar-brand-large .fa-tooth {
            font-size: 1.5rem;
        }

        .nav-item .nav-link { color: #333; font-weight: 500; margin: 0 10px; font-size: 1rem; }

        .top-bar {
            background-color: #f8f9fa;
            padding: 8px 0;
            font-size: 0.95rem;
            border-bottom: 1px solid #eee;
        }
        .top-bar .phone-button {
            background-color: #ffc107;
            color: #333;
            font-weight: bold;
            border-radius: 25px;
            padding: 8px 15px;
            transition: background-color 0.3s;
            font-size: 0.95rem;
        }
        .top-bar .phone-button:hover { background-color: #e0a800; }

        .custom-font-brush {
            font-family: "Brush Script MT", cursive, sans-serif;
            font-weight: normal;
        }

        .hero-section {
            background-color: #007bff;
            color: white;
            padding: 100px 0;
            min-height: 450px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .hero-title { font-size: 4rem; font-weight: 900; margin-bottom: 20px; }
        .hero-subtitle { font-size: 1.35rem; opacity: 0.8; margin-bottom: 30px; }

        .btn-booking {
            background-color: #ffc107;
            color: #333;
            font-size: 1.2rem;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 30px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.5);
            border: 2px solid #ffc107;
        }
        .btn-booking:hover {
            background-color: #e0a800;
            color: #333;
            box-shadow: 0 8px 20px rgba(255, 193, 7, 0.7);
            transform: translateY(-2px);
        }

        .service-section { padding: 80px 0; text-align: center; }
        .service-card {
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            min-height: 250px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .service-icon {
            font-size: 2.5rem;
            color: #007bff;
            margin-bottom: 15px;
            border: 2px solid #007bff;
            border-radius: 50%;
            padding: 10px;
            line-height: 1;
        }

        @media (max-width: 991.98px) {
            .top-bar { display: none; }
        }
    </style>
</head>
<body>
<div class="top-bar d-none d-lg-block">
    <div class="container-xl">
        <div class="row align-items-center">

            <div class="col-lg-4 text-start d-flex align-items-center">

                <span class="custom-font-brush text-secondary me-2" style="font-size: 1.5rem;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            Xin chào
                        </c:when>
                        <c:otherwise>
                            Chào mừng!
                        </c:otherwise>
                    </c:choose>
                </span>

                <a class="navbar-brand fw-bold text-primary navbar-brand-large ms-3" href="<c:url value='/home'/>">
                    <i class="fas fa-tooth text-primary"></i> DreamTooth
                </a>
            </div>

            <div class="col-lg-4 text-center d-flex justify-content-center align-items-center">
                <p class="mb-0 text-muted small">
                    <i class="far fa-clock ms-1 text-primary me-2"></i>
                    <span id="liveClock" class="fw-bold text-dark">Đang tải...</span>
                </p>
            </div>

            <div class="col-lg-4 text-end d-flex justify-content-end align-items-center">
                <ul class="navbar-nav d-flex flex-row me-3">
                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a class="nav-link text-danger" href="<c:url value='/logout'/>" title="Đăng xuất">
                                    <i class="fas fa-sign-out-alt me-1"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/login'/>" class="nav-link text-success" title="Đăng nhập">
                                    <i class="fas fa-sign-in-alt me-1"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
                <a href="tel:0123456789" class="btn phone-button">
                    <i class="fas fa-phone-alt me-1"></i> 0123 456 789
                </a>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg custom-navbar sticky-top">
    <div class="container-xl">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0 d-flex align-items-center flex-nowrap overflow-auto">

                <li class="nav-item me-3">
                    <a class="nav-link active text-nowrap" href="<c:url value='/home'/>">
                        <i class="fas fa-home me-1"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link text-nowrap" href="<c:url value='/services'/>">
                        <i class="fas fa-tooth me-1"></i> Dịch vụ
                    </a>
                </li>
                <%-- Menu Đặt lịch (Role 1, 2, 3): Dùng +0 để ép kiểu số học --%>
                <c:if test="${sessionScope.userRoleId + 0 ge 1 and sessionScope.userRoleId + 0 le 3}">
                    <li class="nav-item me-3">
                        <a class="nav-link text-nowrap" href="<c:url value='/appointments/new'/>">
                            <i class="fas fa-calendar-alt me-1"></i> Đặt lịch
                        </a>
                    </li>
                </c:if>

                <li class="nav-item me-3">
                    <a class="nav-link text-nowrap" href="<c:url value='/reviews?action=list'/>">
                        <i class="fas fa-star me-1"></i> Đánh giá
                    </a>
                </li>

                <%-- Biến kiểm tra chung cho Hồ sơ cá nhân và Bệnh án (Role 1, 2, 3) --%>
                <c:set var="hasPatientAccess" value="${sessionScope.userRoleId + 0 ge 1 and sessionScope.userRoleId + 0 le 3}" />

                <%-- Hồ sơ cá nhân: Loại bỏ logic chuyển hướng dư thừa --%>
                <c:if test="${hasPatientAccess}">
                    <li class="nav-item me-3">
                        <c:url var="userDetailUrl" value="/users" />
                        <a class="nav-link text-nowrap" href="${userDetailUrl}"><i class="fas fa-id-card me-2"></i> Hồ sơ cá nhân</a>
                    </li>
                </c:if>

                <%-- Bệnh án: Loại bỏ logic chuyển hướng dư thừa --%>
                <c:if test="${hasPatientAccess}">
                    <li class="nav-item me-3">
                        <c:url var="medicalRecordsUrl" value="/medical-records?action=list" />
                        <a class="nav-link text-nowrap" href="${medicalRecordsUrl}">
                            <i class="fas fa-file-medical me-2"></i> Bệnh án
                        </a>
                    </li>
                </c:if>

                <%-- Đăng ký nhanh (Role 1, 2) --%>
                <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
                    <li class="nav-item me-3">
                        <a class="nav-link text-nowrap" href="<c:url value='/guest-requests?action=list'/>">
                            <i class="fas fa-clipboard-list me-2"></i> Đăng ký nhanh
                        </a>
                    </li>
                </c:if>

                <%-- Chức năng Admin (Role 1) --%>
                <c:if test="${sessionScope.userRoleId + 0 eq 1}">
                    <li class="nav-item me-3"><a class="nav-link text-nowrap" href="<c:url value='/users?action=addForm'/>"><i class="fas fa-user-plus me-2"></i> Thêm người dùng</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<div class="hero-section">
    <div class="container-xl">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="hero-title">Chăm sóc nụ cười của bạn từ hôm nay</h1>
                <p class="hero-subtitle">
                    Phòng khám nha khoa hiện đại với đội ngũ bác sĩ chuyên nghiệp
                </p>
                <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking">
                    <i class="fas fa-calendar-alt me-2"></i> Đặt lịch ngay
                </a>
            </div>
        </div>
    </div>
</div>

<hr class="my-0">
<div class="service-section">
    <div class="container-xl">
        <h2 class="fw-bold mb-5" style="font-size: 2rem;">Dịch vụ nổi bật</h2>
        <div class="row g-4 justify-content-center">

            <div class="col-md-4">
                <c:url var="service1DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="1"/>
                </c:url>
                <a href="${service1DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-search service-icon"></i>
                        <h5 class="fw-bold">Khám tổng quát Răng miệng</h5>
                        <p class="text-muted small">Kiểm tra, chụp X-quang phát hiện sớm bệnh lý.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="service2DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="2"/>
                </c:url>
                <a href="${service2DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-spray-can service-icon"></i>
                        <h5 class="fw-bold">Cạo vôi Răng & Đánh bóng</h5>
                        <p class="text-muted small">Loại bỏ cao răng, mảng bám bằng máy siêu âm.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="service3DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="3"/>
                </c:url>
                <a href="${service3DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-fill-drip service-icon"></i>
                        <h5 class="fw-bold">Trám Răng Thẩm mỹ</h5>
                        <p class="text-muted small">Phục hồi răng sâu, mẻ bằng vật liệu Composite.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="service4DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="4"/>
                </c:url>
                <a href="${service4DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-tooth service-icon"></i>
                        <h5 class="fw-bold">Tẩy Trắng Răng</h5>
                        <p class="text-muted small">Công nghệ plasma Beyond, răng trắng sáng an toàn.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="service5DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="5"/>
                </c:url>
                <a href="${service5DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-procedures service-icon"></i>
                        <h5 class="fw-bold">Cấy ghép Implant Đơn lẻ</h5>
                        <p class="text-muted small">Phục hình răng mất bằng trụ Implant Thụy Sĩ, bảo hành trọn đời.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="service6DetailUrl" value="/service_demo_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="6"/>
                </c:url>
                <a href="${service6DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card bg-white">
                        <i class="fas fa-user-md service-icon"></i>
                        <h5 class="fw-bold">Niềng Răng Mắc cài Kim loại</h5>
                        <p class="text-muted small">Giải pháp chỉnh nha hiệu quả, chi phí tối ưu.</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="mt-5">
            <a href="<c:url value='/services?action=list'/>" class="btn btn-outline-primary btn-lg">Xem tất cả Dịch vụ</a>
        </div>
    </div>

    <div class="container-xl mt-5">
        <h2 class="fw-bold mb-5" style="font-size: 2rem; text-align: center;">Đội ngũ Bác sĩ chuyên khoa</h2>

        <div class="row g-4 justify-content-center">

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-user-md service-icon" style="color: #28a745; border-color: #28a745;"></i>
                    <h5 class="fw-bold mt-2">BS. Nguyễn Văn A</h5>
                    <p class="text-muted small">Chuyên khoa: **Nha khoa Thẩm mỹ**</p>
                    <p class="text-muted small mb-0">10 năm kinh nghiệm Tẩy trắng và Veneer.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-procedures service-icon" style="color: #ffc107; border-color: #ffc107;"></i>
                    <h5 class="fw-bold mt-2">TS. Lê Thị B</h5>
                    <p class="text-muted small">Chuyên khoa: **Cấy ghép Implant**</p>
                    <p class="text-muted small mb-0">Chứng chỉ Implant Quốc tế</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-tooth service-icon" style="color: #dc3545; border-color: #dc3545;"></i>
                    <h5 class="fw-bold mt-2">BSCKI. Trần Văn C</h5>
                    <p class="text-muted small">Chuyên khoa: **Niềng răng - Chỉnh nha**</p>
                    <p class="text-muted small mb-0">Chuyên gia Niềng răng mắc cài và Invisalign.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-search service-icon" style="color: #007bff; border-color: #007bff;"></i>
                    <h5 class="fw-bold mt-2">BS. Phạm Thu D</h5>
                    <p class="text-muted small">Chuyên khoa: **Nha khoa Tổng quát**</p>
                    <p class="text-muted small mb-0">Chuyên sâu khám và điều trị nội nha cơ bản.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-baby service-icon" style="color: #6f42c1; border-color: #6f42c1;"></i>
                    <h5 class="fw-bold mt-2">BS. Hoàng Mạnh E</h5>
                    <p class="text-muted small">Chuyên khoa: **Nha khoa Trẻ em**</p>
                    <p class="text-muted small mb-0">Tiên phong trong dự phòng và điều trị răng trẻ em.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="service-card bg-white">
                    <i class="fas fa-crown service-icon" style="color: #fd7e14; border-color: #fd7e14;"></i>
                    <h5 class="fw-bold mt-2">BSCKII. Mai Xuân F</h5>
                    <p class="text-muted small">Chuyên khoa: **Phục hình Răng sứ**</p>
                    <p class="text-muted small mb-0">Chuyên gia làm răng sứ, cầu răng, hàm giả tháo lắp.</p>
                </div>
            </div>
        </div>

        <div class="text-center mt-5">
<%--            <a href="<c:url value='/doctors'/>" class="btn btn-outline-secondary btn-lg">Xem tất cả Bác sĩ</a>--%>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function updateClock() {
        const now = new Date();

        const timeOptions = {
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false
        }

        const dateOptions = {
            weekday : "long",
            day:"2-digit",
            month:"2-digit",
            year: "numeric"
        };

        const timeString = now.toLocaleTimeString('vi-VN', timeOptions);
        const dateString = now.toLocaleDateString('vi-VN', dateOptions);

        const clockElement = document.getElementById('liveClock');

        if (clockElement) {
            clockElement.innerHTML = dateString + ', ' + timeString;
        }

    }

    updateClock();
    setInterval(updateClock, 1000);
</script>
</body>
</html>