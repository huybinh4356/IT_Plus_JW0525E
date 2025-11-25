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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
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
            background-color: #8CE4FF;
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
        .doctor-section { padding: 80px 0 ; text-align: center; }
        @media (max-width: 991.98px) {
            .top-bar { display: none; }
        }
        .service-card .service-img, .service-card .sevices-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
            margin-bottom: 15px;
            border-radius: 8px;
        }
        .service-card {
            text-align: center;
            padding: 20px;
            height: 100%;
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
        .footer-info-text { color: #FFFFFF !important; font-weight: 400; }
        .owl-nav button {
            position: absolute;
            top: 40%;
            transform: translateY(-50%);
            width: 40px;
            height: 40px;
            background-color: #fff !important;
            border-radius: 50% !important;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            color: #007bff !important;
            font-size: 2rem !important;
            display: flex !important;
            align-items: center; justify-content: center;
        }
        .owl-nav button:hover { background-color: #007bff !important; color: white !important; }
        .owl-prev { left: -20px; }
        .owl-next { right: -20px; }
        .social-icons a:hover { color: #ffc107 !important; transition: color 0.3s; }
    </style>
</head>
<body>
<div class="top-bar d-none d-lg-block">
    <div class="container-xl">
        <div class="row align-items-center">

            <%-- Cột 1: Chào mừng --%>
            <div class="col-lg-4 text-start d-flex align-items-center">
                <span class="custom-font-brush text-secondary me-2" style="font-size: 1.5rem;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">Xin chào</c:when>
                        <c:otherwise>Chào mừng!</c:otherwise>
                    </c:choose>
                </span>
                <a class="navbar-brand fw-bold text-primary navbar-brand-large ms-3" href="<c:url value='/home'/>">
                    <i class="fas fa-tooth text-primary"></i> DreamTooth
                </a>
            </div>

            <%-- Cột 2: Đồng hồ --%>
            <div class="col-lg-4 text-center d-flex justify-content-center align-items-center">
                <p class="mb-0 text-muted small">
                    <i class="far fa-clock ms-1 text-primary me-2"></i>
                    <span id="liveClock" class="fw-bold text-dark">Đang tải...</span>
                </p>
            </div>

            <%-- Cột 3: Giỏ hàng, Login, SĐT --%>
            <div class="col-lg-4 text-end d-flex justify-content-end align-items-center">
                <ul class="navbar-nav d-flex flex-row me-3 align-items-center">

                    <%-- === ICON GIỎ HÀNG (MỚI THÊM) === --%>
                    <li class="nav-item me-3">
                        <a href="<c:url value='/wishlist'/>" class="nav-link position-relative text-secondary" title="Danh sách quan tâm">
                            <i class="fas fa-shopping-cart fa-lg"></i>
                            <%-- Badge đếm số lượng (Nếu session có biến wishlistSize) --%>
                            <c:if test="${not empty sessionScope.wishlistSize && sessionScope.wishlistSize > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                                        ${sessionScope.wishlistSize}
                                </span>
                            </c:if>
                        </a>
                    </li>
                    <%-- === KẾT THÚC ICON GIỎ HÀNG === --%>

                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a class="nav-link text-danger" href="<c:url value='/logout'/>" title="Đăng xuất"><i class="fas fa-sign-out-alt me-1"></i></a>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/login'/>" class="nav-link text-success" title="Đăng nhập"><i class="fas fa-sign-in-alt me-1"></i></a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
                <a href="tel:0123456789" class="btn phone-button"><i class="fas fa-phone-alt me-1"></i> 0123 456 789</a>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg custom-navbar sticky-top">
    <div class="container-xl">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0 d-flex align-items-center flex-nowrap overflow-auto">
                <li class="nav-item me-3"><a class="nav-link active" href="<c:url value='/home'/>"><i class="fas fa-home me-1"></i> Trang chủ</a></li>
                <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/services?action=list'/>"><i class="fas fa-tooth me-1"></i> Dịch vụ</a></li>
                <c:if test="${sessionScope.userRoleId + 0 eq 1 || sessionScope.userRoleId + 0 eq 2}">
                    <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/appointments?action=list'/>"><i class="fas fa-calendar-alt me-1"></i> Quản lý Lịch hẹn</a></li>
                </c:if>
                <c:if test="${sessionScope.userRoleId + 0 eq 3}">
                    <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/appointments/new'/>"><i class="fas fa-calendar-alt me-1"></i> Đặt lịch</a></li>
                </c:if>
                <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/reviews?action=list'/>"><i class="fas fa-star me-1"></i> Đánh giá</a></li>
                <c:set var="hasPatientAccess" value="${sessionScope.userRoleId + 0 ge 1 and sessionScope.userRoleId + 0 le 3}" />
                <c:if test="${hasPatientAccess}">
                    <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/users'/>"><i class="fas fa-id-card me-2"></i> Hồ sơ cá nhân</a></li>
                    <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/medical-records?action=list'/>"><i class="fas fa-file-medical me-2"></i> Bệnh án</a></li>
                </c:if>
                <c:if test="${sessionScope.userRoleId + 0 eq 1}">
                    <li class="nav-item me-3"><a class="nav-link" href="<c:url value='/users?action=addForm'/>"><i class="fas fa-user-plus me-2"></i> Thêm người dùng</a></li>
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
                <p class="hero-subtitle">Phòng khám nha khoa hiện đại với đội ngũ bác sĩ chuyên nghiệp</p>
                <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking"><i class="fas fa-calendar-alt me-2"></i> Đặt lịch ngay</a>
            </div>
        </div>
    </div>
</div>

<hr class="my-0">

<div class="service-section">
    <div class="container-xl">
        <h2 class="fw-bold mb-5" style="font-size: 2rem;">Dịch vụ nổi bật</h2>
        <div class="owl-carousel owl-theme service-carousel">

            <c:if test="${not empty listServices}">
                <c:forEach items="${listServices}" var="s">
                    <div class="item p-2">
                        <c:url var="serviceDetailUrl" value="/service_demo_list">
                            <c:param name="action" value="detail"/>
                            <c:param name="id" value="${s.id}"/>
                        </c:url>
                        <a href="${serviceDetailUrl}" class="text-decoration-none d-block h-100">
                            <div class="service-card">
                                <img src="${pageContext.request.contextPath}/assets/images/${s.image != null ? s.image : 'default.png'}" alt="${s.serviceName}" class="service-img">
                                <h5 class="fw-bold mt-3">${s.serviceName}</h5>
                                <p class="text-muted small text-truncate" style="max-width: 100%;">${s.description}</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty listServices}">
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='1'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_5.png" class="service-img"><h5 class="fw-bold">Khám tổng quát</h5><p class="text-muted small">Kiểm tra, chụp X-quang.</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='2'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_6.png" class="service-img"><h5 class="fw-bold">Cạo vôi Răng</h5><p class="text-muted small">Loại bỏ cao răng.</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='3'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_4.png" class="service-img"><h5 class="fw-bold">Trám Răng</h5><p class="text-muted small">Phục hồi răng sâu.</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='4'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_7.png" class="service-img"><h5 class="fw-bold">Tẩy Trắng</h5><p class="text-muted small">Công nghệ plasma.</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='5'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_8.png" class="service-img"><h5 class="fw-bold">Cấy ghép Implant</h5><p class="text-muted small">Phục hình răng mất.</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/service_demo_list'><c:param name='action' value='detail'/><c:param name='id' value='6'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/img_9.png" class="service-img"><h5 class="fw-bold">Niềng Răng</h5><p class="text-muted small">Chỉnh nha hiệu quả.</p></div>
                    </a>
                </div>
            </c:if>
        </div>
        <div class="mt-5">
            <a href="<c:url value='/services?action=list'/>" class="btn btn-outline-primary btn-lg">Xem tất cả Dịch vụ</a>
        </div>
    </div>
</div>

<hr class="my-0">

<div class="hero-section">
    <div class="container-xl">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="hero-title">Chăm sóc nụ cười của bạn từ hôm nay</h1>
                <p class="hero-subtitle">Phòng khám nha khoa hiện đại với đội ngũ bác sĩ chuyên nghiệp</p>
                <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking"><i class="fas fa-calendar-alt me-2"></i> Đặt lịch ngay</a>
            </div>
        </div>
    </div>
</div>

<hr class="my-0">

<div class="doctor-section">
    <div class="container-xl">
        <h2 class="fw-bold mb-5" style="font-size: 2rem; text-align: center;">Đội ngũ Bác sĩ chuyên khoa</h2>
        <div class="owl-carousel owl-theme doctor-carousel">
            <c:if test="${not empty listDoctors}">
                <c:forEach items="${listDoctors}" var="d">
                    <div class="item p-2">
                        <c:url var="doctorDetailUrl" value="/doctor_list">
                            <c:param name="action" value="detail"/>
                            <c:param name="id" value="${d.id}"/>
                        </c:url>
                        <a href="${doctorDetailUrl}" class="text-decoration-none d-block h-100">
                            <div class="service-card">
                                <img src="${pageContext.request.contextPath}/assets/images/doctor-img/${d.image != null ? d.image : 'default.png'}" alt="${d.fullName}" class="sevices-img">
                                <h5 class="fw-bold mt-2">BS. ${d.fullName}</h5>
                                <p class="text-muted small">Chuyên khoa: <strong>${d.specialty}</strong></p>
                                <p class="text-muted small mb-0 text-truncate">${d.experience}</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty listDoctors}">
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='1'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" class="sevices-img"><h5 class="fw-bold">BS. Nguyễn Văn A</h5><p class="text-muted small">Nha khoa Thẩm mỹ</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='2'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" class="sevices-img"><h5 class="fw-bold">TS. Lê Thị B</h5><p class="text-muted small">Cấy ghép Implant</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='3'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" class="sevices-img"><h5 class="fw-bold">BS. Trần Văn C</h5><p class="text-muted small">Niềng răng</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='4'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" class="sevices-img"><h5 class="fw-bold">BS. Phạm Thu D</h5><p class="text-muted small">Nha khoa Tổng quát</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='5'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" class="sevices-img"><h5 class="fw-bold">BS. Hoàng Mạnh E</h5><p class="text-muted small">Nha khoa Trẻ em</p></div>
                    </a>
                </div>
                <div class="item p-2">
                    <a href="<c:url value='/doctor_list'><c:param name='action' value='detail'/><c:param name='id' value='6'/></c:url>" class="text-decoration-none d-block h-100">
                        <div class="service-card"><img src="${pageContext.request.contextPath}/assets/images/doctor-img/img_1.png" class="sevices-img"><h5 class="fw-bold">BS. Mai Xuân F</h5><p class="text-muted small">Phục hình Răng sứ</p></div>
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<footer class="bg-dark text-white pt-5 pb-4 mt-5">
    <div class="container-xl">
        <div class="row g-4">
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-warning"><i class="fas fa-tooth me-2"></i> DREAMTOOTH CLINIC</h5>
                <p class="small text-muted">Phòng khám nha khoa hàng đầu.</p>
                <div class="d-flex social-icons mt-3">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">DỊCH VỤ & LIÊN KẾT</h5>
                <ul class="list-unstyled">
                    <li><a href="<c:url value='/services'/>" class="text-muted text-decoration-none small">Dịch vụ nổi bật</a></li>
                    <li><a href="<c:url value='/doctor_list'/>" class="text-muted text-decoration-none small">Đội ngũ Bác sĩ</a></li>
                </ul>
            </div>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">CN 1: HÀ NỘI</h5>
                <ul class="list-unstyled"><li class="small mb-2"><span class="footer-info-text">123 Nguyễn Trãi, Hà Nội</span></li></ul>
            </div>
            <div class="col-md-3 col-sm-6">
                <h5 class="text-uppercase fw-bold mb-3 text-white">CN 2: HỒ CHÍ MINH</h5>
                <ul class="list-unstyled"><li class="small mb-2"><span class="footer-info-text">456 Lê Lợi, TP. HCM</span></li></ul>
            </div>
        </div>
        <hr class="my-4 border-secondary">
        <div class="row"><div class="col-12 text-center"><p class="mb-0 small text-muted">&copy; <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> DreamTooth.</p></div></div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<script>
    $(document).ready(function(){
        $(".service-carousel, .doctor-carousel").owlCarousel({
            loop: true,
            margin: 20,
            nav: true,
            navText: ["<i class='fas fa-chevron-left'></i>", "<i class='fas fa-chevron-right'></i>"],
            dots: true,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true,
            responsive: {
                0: { items: 1 },
                600: { items: 2 },
                1000: { items: 3 }
            }
        });
    });

    function updateClock() {
        const now = new Date();
        const clockElement = document.getElementById('liveClock');
        if (clockElement) {
            clockElement.innerHTML = now.toLocaleDateString('vi-VN') + ', ' + now.toLocaleTimeString('vi-VN');
        }
    }
    updateClock();
    setInterval(updateClock, 1000);
</script>
</body>
</html>