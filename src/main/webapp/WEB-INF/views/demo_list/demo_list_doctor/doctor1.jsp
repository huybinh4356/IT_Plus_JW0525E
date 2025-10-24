<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Bác Sĩ: BS. Nguyễn Văn A - Nha khoa Thẩm mỹ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Inter', sans-serif;
            font-size: 1.1rem;
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        /* Đặt màu tiêu đề về Xanh dương mặc định để dễ nhìn */
        .section-title { font-size: 2.2rem; font-weight: 700; color: #007bff; margin-bottom: 30px; }

        .detail-hero-section {
            background-image: url('${pageContext.request.contextPath}/assets/images/img.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            padding: 100px 0;
            min-height: 350px;
            display: flex;
            align-items: center;
            position: relative;
            z-index: 1;
            text-shadow: 0 0 5px rgba(0, 0, 0, 0.7);
        }
        .detail-hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.3); /* Overlay tối nhẹ (đen 30%) */
            z-index: -1;
        }
        .detail-hero-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 5px;
            color: #FFFFFF; /* Màu Trắng tinh */
        }
        .detail-hero-subtitle {
            font-size: 1.5rem;
            opacity: 0.9;
            margin-bottom: 40px;
            font-weight: 500;
            color: #F0F0F0; /* Trắng ngà */
        }

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
        .content-box {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }

        .doctor-profile-img {
            width: 100%;
            max-width: 300px;
            height: auto;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            border: 6px solid #e9ecef; /* Giữ viền sáng nhẹ */
        }
        .doctor-info-box {
            background-color: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            border-left: 5px solid #333333; /* Đổi viền sang Xám đậm để dễ nhìn */
        }
        .achievement-item {
            font-size: 1rem;
            padding: 10px 0;
            border-bottom: 1px dashed #e9ecef;
        }
        .achievement-item:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>

<div class="detail-hero-section text-center">
    <div class="container-xl">
        <h1 class="detail-hero-title">BS. NGUYỄN VĂN A</h1>
        <p class="detail-hero-subtitle">Chuyên gia hàng đầu về Nha khoa Thẩm mỹ và Phục hồi</p>
        <a href="<c:url value='/guest-requests?action=addForm&doctor=A'/>" class="btn btn-booking">
            <i class="fas fa-calendar-alt me-2"></i> Đặt lịch Khám với Bác sĩ A
        </a>
    </div>
</div>

<div class="content-section">
    <div class="container-xl">
        <div class="content-box">

            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb bg-light p-2 rounded-3">
                    <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none text-dark">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">BS. Nguyễn Văn A</li>
                </ol>
            </nav>

            <div class="row g-5">
                <div class="col-lg-12">

                    <div class="row g-4 mb-5">
                        <div class="col-md-5 text-center">
                            <img src="${pageContext.request.contextPath}/assets/images/doctor-img/img.png" alt="Ảnh chân dung Bác sĩ Nguyễn Văn A" class="doctor-profile-img">
                        </div>
                        <div class="col-md-7">
                            <h2 class="section-title mb-3">Giới Thiệu Chung</h2>
                            <div class="doctor-info-box">
                                <p class="lead fw-bold text-primary">
                                    <i class="fas fa-graduation-cap me-2"></i> Trình độ chuyên môn: <span class="text-dark">Thạc sĩ Nha khoa (M.D.S)</span>
                                </p>
                                <p class="lead fw-bold text-primary">
                                    <i class="fas fa-user-tag me-2"></i> Chuyên khoa chính: <span class="text-dark">Nha khoa Thẩm mỹ & Phục hình</span>
                                </p>
                                <p class="lead fw-bold text-primary">
                                    <i class="fas fa-calendar-alt me-2"></i> Kinh nghiệm: <span class="text-dark">Trên 10 năm hành nghề</span>
                                </p>
                                <p class="lead">
                                    **BS. Nguyễn Văn A** là thành viên Hiệp hội Nha khoa Việt Nam và là chuyên gia với bề dày kinh nghiệm trong việc tái tạo nụ cười hoàn hảo, đặc biệt là các kỹ thuật bảo tồn như **Veneer không mài** và **Tẩy trắng công nghệ cao**.
                                </p>
                            </div>
                        </div>
                    </div>

                    <hr class="my-5">

                    <h2 class="section-title">1. Lĩnh Vực Chuyên Sâu</h2>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-teeth feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Phục hình Răng Sứ Thẩm mỹ</h5>
                                        <p class="card-text text-muted">Chuyên sâu về Veneer và bọc sứ theo tiêu chuẩn Châu Âu.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-paint-roller feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Tẩy Trắng Răng Chuyên nghiệp</h5>
                                        <p class="card-text text-muted">Thực hiện các ca tẩy trắng cho răng nhạy cảm, nhiễm màu nặng.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-tooth feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Nha khoa Tổng quát và Bảo tồn</h5>
                                        <p class="card-text text-muted">Điều trị tủy, trám răng, phát hiện và ngăn ngừa bệnh nha chu.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-microphone-alt feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Tư vấn Thiết kế Nụ cười</h5>
                                        <p class="card-text text-muted">Sử dụng công nghệ DSD (Digital Smile Design) hiện đại.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="my-5">

                    <h2 class="section-title">2. Thành Tựu và Chứng Chỉ Nổi Bật</h2>
                    <div class="card bg-light p-4 mb-4 border-0 shadow-sm">
                        <ul class="list-unstyled">
                            <li class="d-flex align-items-start achievement-item">
                                <span class="text-success me-3"><i class="fas fa-award fa-lg"></i></span>
                                <div>
                                    <strong class="text-dark">Chứng chỉ Master of Veneer</strong>
                                    <p class="text-muted mb-0 small">Được cấp bởi Học viện Nha khoa Quốc tế (IADI), Singapore.</p>
                                </div>
                            </li>
                            <li class="d-flex align-items-start achievement-item">
                                <span class="text-success me-3"><i class="fas fa-trophy fa-lg"></i></span>
                                <div>
                                    <strong class="text-dark">Giải thưởng "Bàn Tay Vàng" Nha khoa Thẩm mỹ</strong>
                                    <p class="text-muted mb-0 small">Giải thưởng danh giá năm 2020 do Hiệp hội Nha sĩ trẻ bình chọn.</p>
                                </div>
                            </li>
                            <li class="d-flex align-items-start achievement-item">
                                <span class="text-success me-3"><i class="fas fa-book-open fa-lg"></i></span>
                                <div>
                                    <strong class="text-dark">Tác giả của 3 công trình nghiên cứu khoa học</strong>
                                    <p class="text-muted mb-0 small">Về ứng dụng Laser trong điều trị nha chu và bảo tồn mô răng.</p>
                                </div>
                            </li>
                        </ul>
                    </div>

                </div>

                <div class="col-lg-12 text-center mt-4">
                    <h2 class="section-title">Hãy để Bác sĩ A chăm sóc nụ cười của bạn</h2>
                    <a href="<c:url value='/guest-requests?action=addForm&doctor=A'/>" class="btn btn-booking btn-lg">
                        <i class="fas fa-calendar-check me-2"></i> Đặt lịch Tư vấn 1-1 ngay hôm nay
                    </a>
                </div>
            </div>

            <hr class="my-5">

            <div class="text-center">
                <a href="/home" class="btn btn-outline-secondary btn-lg"><i class="fas fa-arrow-left me-2"></i> Quay lại Danh sách Bác sĩ</a>
            </div>

        </div> </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>