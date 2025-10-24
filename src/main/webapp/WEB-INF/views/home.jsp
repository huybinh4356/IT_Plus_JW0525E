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

        .service-section {
            padding: 80px 0;
            text-align: center;
        }

        .doctor-section {
            padding-bottom: 80px;
            text-align: center;
        }

        @media (max-width: 991.98px) {
            .top-bar { display: none; }
        }

        /* ---------------------------------------------------- */
        /* CSS CHỈNH SỬA CHO ẢNH DỊCH VỤ (service-img) */
        /* ---------------------------------------------------- */
        .service-card .service-img {
            width: 100%;
            max-width: 100%;
            height: 200px; /* Chiều cao cố định cho ảnh dịch vụ */
            object-fit: cover; /* Cắt ảnh để vừa với khung, giữ tỷ lệ */
            display: block;
            margin-bottom: 15px;
            border-radius: 8px;
        }

        /* ---------------------------------------------------- */
        /* CSS GỐC CHO ẢNH BÁC SĨ (sevices-img) - Giữ nguyên */
        /* ---------------------------------------------------- */
        .service-card .sevices-img {
            max-width: 100%;
            height: auto; /* Chiều cao tự động, giữ tỷ lệ gốc */
            display: block;
            margin-bottom: 15px;
            border-radius: 8px;
        }


        .service-card .service-icon {
            font-size: 3rem;
            color: #007bff;
            margin-bottom: 15px;
            border: 2px solid transparent;
            padding: 10px;
            line-height: 1;
        }

        .service-card {
            text-align: center;
            padding: 20px;
            min-height: 250px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,.07);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            background-color: #ffffff;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,.15);
        }

        /* Đảm bảo nội dung text trong footer là màu trắng */
        .footer-info-text {
            color: #FFFFFF !important; /* Dùng màu trắng để nổi bật */
            font-weight: 400;
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

                <c:set var="hasPatientAccess" value="${sessionScope.userRoleId + 0 ge 1 and sessionScope.userRoleId + 0 le 3}" />

                <c:if test="${hasPatientAccess}">
                    <li class="nav-item me-3">
                        <c:url var="userDetailUrl" value="/users" />
                        <a class="nav-link text-nowrap" href="${userDetailUrl}"><i class="fas fa-id-card me-2"></i> Hồ sơ cá nhân</a>
                    </li>
                </c:if>

                <c:if test="${hasPatientAccess}">
                    <li class="nav-item me-3">
                        <c:url var="medicalRecordsUrl" value="/medical-records?action=list" />
                        <a class="nav-link text-nowrap" href="${medicalRecordsUrl}">
                            <i class="fas fa-file-medical me-2"></i> Bệnh án
                        </a>
                    </li>
                </c:if>

                <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
                    <li class="nav-item me-3">
                        <a class="nav-link text-nowrap" href="<c:url value='/guest-requests?action=list'/>">
                            <i class="fas fa-clipboard-list me-2"></i> Đăng ký nhanh
                        </a>
                    </li>
                </c:if>

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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_5.png" alt="Khám tổng quát Răng miệng" class="service-img">
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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_6.png" alt="Cạo vôi Răng & Đánh bóng" class="service-img">
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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_4.png" alt="Trám Răng Thẩm mỹ" class="service-img">
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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_7.png" alt="Tẩy Trắng Răng" class="service-img">
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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_8.png" alt="Cấy ghép Implant Đơn lẻ" class="service-img">
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
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/img_9.png" alt="Niềng Răng Mắc cài Kim loại" class="service-img">
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
</div>

<div class="doctor-section">
    <div class="container-xl">
        <h2 class="fw-bold mb-5" style="font-size: 2rem; text-align: center;">Đội ngũ Bác sĩ chuyên khoa</h2>

        <div class="row g-4 justify-content-center">

            <div class="col-md-4">
                <c:url var="doctor1DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="1"/>
                </c:url>
                <a href="${doctor1DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" alt="Bác sĩ Nguyễn Văn A" class="sevices-img">
                        <h5 class="fw-bold mt-2">BS. Nguyễn Văn A</h5>
                        <p class="text-muted small">Chuyên khoa: **Nha khoa Thẩm mỹ**</p>
                        <p class="text-muted small mb-0">10 năm kinh nghiệm Tẩy trắng và Veneer.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="doctor2DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="2"/>
                </c:url>
                <a href="${doctor2DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" alt="Bác sĩ Lê Thị B" class="sevices-img">
                        <h5 class="fw-bold mt-2">TS. Lê Thị B</h5>
                        <p class="text-muted small">Chuyên khoa: **Cấy ghép Implant**</p>
                        <p class="text-muted small mb-0">Chứng chỉ Implant Quốc tế</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="doctor3DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="3"/>
                </c:url>
                <a href="${doctor3DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" alt="Bác sĩ Trần Văn C" class="sevices-img">
                        <h5 class="fw-bold mt-2">BSCKI. Trần Văn C</h5>
                        <p class="text-muted small">Chuyên khoa: **Niềng răng - Chỉnh nha**</p>
                        <p class="text-muted small mb-0">Chuyên gia Niềng răng mắc cài và Invisalign.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="doctor4DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="4"/>
                </c:url>
                <a href="${doctor4DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" alt="Bác sĩ Phạm Thu D" class="sevices-img">
                        <h5 class="fw-bold mt-2">BS. Phạm Thu D</h5>
                        <p class="text-muted small">Chuyên khoa: **Nha khoa Tổng quát**</p>
                        <p class="text-muted small mb-0">Chuyên sâu khám và điều trị nội nha cơ bản.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="doctor5DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="5"/>
                </c:url>
                <a href="${doctor5DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" alt="Bác sĩ Hoàng Mạnh E" class="sevices-img">
                        <h5 class="fw-bold mt-2">BS. Hoàng Mạnh E</h5>
                        <p class="text-muted small">Chuyên khoa: **Nha khoa Trẻ em**</p>
                        <p class="text-muted small mb-0">Tiên phong trong dự phòng và điều trị răng trẻ em.</p>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <c:url var="doctor6DetailUrl" value="/doctor_list">
                    <c:param name="action" value="detail"/>
                    <c:param name="id" value="6"/>
                </c:url>
                <a href="${doctor6DetailUrl}" class="text-decoration-none d-block">
                    <div class="service-card">
                        <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" alt="Bác sĩ Mai Xuân F" class="sevices-img">
                        <h5 class="fw-bold mt-2">BSCKII. Mai Xuân F</h5>
                        <p class="text-muted small">Chuyên khoa: **Phục hình Răng sứ**</p>
                        <p class="text-muted small mb-0">Chuyên gia làm răng sứ, cầu răng, hàm giả tháo lắp.</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="text-center mt-5">
            <a href="<c:url value='/home'/>" class="btn btn-outline-primary btn-lg">Xem tất cả Bác sĩ</a>
        </div>
    </div>
</div>

<footer class="bg-dark text-white pt-5 pb-4 mt-5">
    <div class="container-xl">
        <div class="row g-4">

            <%-- Cột 1: Thông tin cơ bản --%>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-warning">
                    <i class="fas fa-tooth me-2"></i> DREAMTOOTH CLINIC
                </h5>
                <p class="small text-muted">Phòng khám nha khoa hàng đầu, cam kết mang lại nụ cười rạng rỡ và sức khỏe răng miệng tối ưu.</p>
                <div class="d-flex social-icons mt-3">
                    <a href="https://www.facebook.com" target="_blank" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="https://www.twitter.com" target="_blank" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="https://www.instagram.com" target="_blank" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                </div>
            </div>

            <%-- Cột 2: Dịch vụ & Liên kết nhanh --%>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">DỊCH VỤ & LIÊN KẾT</h5>
                <ul class="list-unstyled">
                    <li><a href="<c:url value='/services'/>" class="text-muted text-decoration-none small">Dịch vụ nổi bật</a></li>
                    <li><a href="<c:url value='/doctor_list'/>" class="text-muted text-decoration-none small">Đội ngũ Bác sĩ</a></li>
                    <li><a href="<c:url value='/reviews?action=list'/>" class="text-muted text-decoration-none small">Đánh giá khách hàng</a></li>
                    <li><a href="<c:url value='/guest-requests?action=addForm'/>" class="text-muted text-decoration-none small">Đặt lịch nhanh</a></li>
                </ul>
            </div>

            <%-- Cột 3: Thông tin Chi nhánh 1 (Hardcode) --%>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">CN 1: HÀ NỘI</h5>
                <ul class="list-unstyled">
                    <li class="small mb-2">
                        <i class="fas fa-map-marker-alt me-2 text-warning"></i>
                        <span class="footer-info-text">123 Nguyễn Trãi, Hà Nội</span>
                    </li>
                    <li class="small mb-2">
                        <i class="fas fa-envelope me-2 text-warning"></i>
                        <span class="footer-info-text">contact@dreamtooth.com</span>
                    </li>
                    <li class="small mb-2">
                        <i class="fas fa-phone-alt me-2 text-warning"></i>
                        <span class="footer-info-text">0123 456 789</span>
                    </li>
                    <li class="small mb-2">
                        <i class="far fa-clock me-2 text-warning"></i>
                        <span class="footer-info-text">8:00 - 20:00</span>
                    </li>
                </ul>
            </div>

            <%-- Cột 4: Thông tin Chi nhánh 2 (Hardcode) & Quản lý (Đã đổi tên) --%>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">CN 2: HỒ CHÍ MINH</h5>
                <ul class="list-unstyled">
                    <li class="small mb-2">
                        <i class="fas fa-map-marker-alt me-2 text-warning"></i>
                        <span class="footer-info-text">456 Lê Lợi, TP. Hồ Chí Minh</span>
                    </li>
                    <li class="small mb-2">
                        <i class="fas fa-envelope me-2 text-warning"></i>
                        <span class="footer-info-text">support@dreamtooth.vn</span>
                    </li>
                    <li class="small mb-2">
                        <i class="fas fa-phone-alt me-2 text-warning"></i>
                        <span class="footer-info-text">0987 654 321</span>
                    </li>
                    <li class="small mb-2">
                        <i class="far fa-clock me-2 text-warning"></i>
                        <span class="footer-info-text">9:00 - 21:00</span>
                    </li>

                    <li class="mt-3 pt-2 border-top border-secondary">
                        <a href="<c:url value='/clinic-info?action=list'/>" class="text-info text-decoration-none fw-bold small">
                            <%-- ĐÃ THAY ĐỔI TỪ "QUẢN LÝ" SANG "DANH SÁCH" --%>
                            <i class="fas fa-cog me-2"></i> DANH SÁCH THÔNG TIN PHÒNG KHÁM
                        </a>
                    </li>
                </ul>
            </div>

        </div>

        <hr class="my-4 border-secondary">

        <%-- Copyright --%>
        <div class="row">
            <div class="col-12 text-center">
                <p class="mb-0 small text-muted">&copy; <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> DreamTooth. Tất cả bản quyền được bảo lưu.</p>
            </div>
        </div>

    </div>
</footer>

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
<style>
    /* Thêm style cho các icon mạng xã hội nếu cần */
    .social-icons a:hover {
        color: #ffc107 !important;
        transition: color 0.3s;
    }
</style>
</body>
</html>