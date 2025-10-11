<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Dịch Vụ #${requestScope.currentServiceId}: Vệ sinh Vôi răng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* CSS Chung cho Trang Chi Tiết (nhất quán với demo1.jsp) */
        body { background-color: #f0f2f5; font-family: 'Inter', sans-serif; font-size: 1.1rem; }
        .section-title { font-size: 2.2rem; font-weight: 700; color: #007bff; margin-bottom: 30px; }

        .detail-hero-section {
            /* ĐÃ CẬP NHẬT ĐƯỜNG DẪN ẢNH */
            background-image: url('${pageContext.request.contextPath}/assets/images/img.png');
            background-size: cover; background-position: center; background-repeat: no-repeat;
            color: white; padding: 100px 0; min-height: 400px; display: flex; align-items: center;
            position: relative; z-index: 1; text-shadow: 0 0 5px rgba(0, 0, 0, 0.7);
        }
        .detail-hero-section::before { content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.2); z-index: -1; }
        .detail-hero-title { font-size: 3.5rem; font-weight: 900; margin-bottom: 5px; color: #ffe082; }
        .detail-hero-subtitle { font-size: 1.5rem; opacity: 0.9; margin-bottom: 40px; font-weight: 500;}

        /* NÚT ĐẶT LỊCH NỔI BẬT */
        .btn-booking {
            background-color: #ffc107; color: #333; font-size: 1.2rem; font-weight: bold; padding: 12px 30px;
            border-radius: 30px; transition: all 0.3s; box-shadow: 0 5px 15px rgba(255, 193, 7, 0.5); border: 2px solid #ffc107;
        }
        .btn-booking:hover {
            background-color: #e0a800; color: #333; box-shadow: 0 8px 20px rgba(255, 193, 7, 0.7); transform: translateY(-2px);
        }

        /* BOX NỀN LỚN CHO NỘI DUNG */
        .content-box {
            background-color: #ffffff; padding: 40px; border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1); margin-top: -50px; position: relative; z-index: 10;
        }

        /* CÁC PHẦN TỬ CON */
        .card-feature {
            background-color: #fff; border-left: 5px solid #007bff; border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); padding: 25px; transition: transform 0.3s, box-shadow 0.3s;
        }
        .card-feature:hover { transform: translateY(-5px); box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12); }
        .feature-icon-large { font-size: 2rem; color: #007bff; margin-right: 15px; }
        .list-group-item.highlighted { background-color: #e9f5ff; border-left: 4px solid #007bff; }
        .sidebar-card {
            background-color: #f8f9fa; border: none; border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); padding: 30px;
        }
        .table-primary { background-color: #007bff !important; color: white; }
    </style>
</head>
<body>

<div class="detail-hero-section text-center">
    <div class="container-xl">
        <h1 class="detail-hero-title">VỆ SINH VÔI RĂNG</h1>
        <p class="detail-hero-subtitle">Giải pháp làm sạch sâu, ngăn ngừa viêm nướu và hôi miệng</p>
        <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking">
            <i class="fas fa-calendar-alt me-2"></i> Đặt lịch làm sạch
        </a>
    </div>
</div>

<div class="content-section">
    <div class="container-xl">
        <div class="content-box">

            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb bg-light p-2 rounded-3">
                    <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none text-dark">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="/service_demo_list" class="text-decoration-none text-dark">Dịch vụ nổi bật</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Vệ sinh vôi răng</li>
                </ol>
            </nav>

            <div class="row g-5">
                <div class="col-lg-8">

                    <h2 class="section-title">1. Tầm quan trọng của Vệ sinh Vôi răng</h2>
                    <p>Vôi răng (hay cao răng) là mảng bám cứng tích tụ lâu ngày, chứa vi khuẩn gây hại. Vệ sinh định kỳ giúp loại bỏ chúng, bảo vệ nướu và ngăn ngừa các bệnh lý nghiêm trọng hơn.</p>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-broom feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Ngăn ngừa Viêm nướu</h5>
                                        <p class="card-text text-muted">Loại bỏ vi khuẩn ẩn sâu dưới nướu.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card card-feature h-100">
                                <div class="card-body d-flex align-items-start">
                                    <i class="fas fa-wind feature-icon-large"></i>
                                    <div>
                                        <h5 class="card-title fw-bold text-dark">Khử mùi hôi miệng</h5>
                                        <p class="card-text text-muted">Vôi răng là nguyên nhân chính gây hôi miệng.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="my-5">

                    <h2 class="section-title">2. Quy trình Vệ sinh Chuyên nghiệp</h2>
                    <p>Chúng tôi sử dụng máy siêu âm Piezotome hiện đại để loại bỏ vôi răng nhẹ nhàng, hiệu quả:</p>
                    <ol class="list-group list-group-numbered shadow-sm mb-4">
                        <li class="list-group-item highlighted">**Kiểm tra tổng quát:** Đánh giá tình trạng vôi răng và nướu.</li>
                        <li class="list-group-item highlighted">**Dùng máy siêu âm:** Rung nhẹ để làm bong mảng bám, không gây tổn thương men răng.</li>
                        <li class="list-group-item highlighted">**Đánh bóng (Polish):** Sử dụng chổi mềm và bột đánh bóng để làm láng mịn bề mặt răng, giảm tái bám.</li>
                        <li class="list-group-item highlighted">**Tư vấn chăm sóc:** Hướng dẫn kỹ thuật chải răng và dùng chỉ nha khoa đúng cách.</li>
                    </ol>

                    <hr class="my-5">

                    <h2 class="section-title">3. Tần suất nên thực hiện</h2>
                    <div class="card bg-light p-4 mb-4 border-0 shadow-sm">
                        <h5 class="text-primary fw-bold mb-3"><i class="fas fa-calendar-alt me-2"></i> Định kỳ</h5>
                        <p>Nên thực hiện **6 tháng/lần** cho hầu hết mọi người.</p>
                        <hr>
                        <h5 class="text-primary fw-bold mb-3"><i class="fas fa-tint me-2"></i> Trường hợp đặc biệt</h5>
                        <p>Đối với người có tiền sử viêm nha chu, tiểu đường, hoặc hút thuốc: nên làm **3 tháng/lần** theo chỉ định của bác sĩ.</p>
                    </div>

                </div>

                <div class="col-lg-4">
                    <div class="card sidebar-card sticky-top" style="top: 20px;">
                        <h4 class="text-center text-primary mb-4 fw-bold">Chi Phí & Thông Tin Nhanh</h4>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item d-flex justify-content-between bg-transparent">
                                <strong>ID Dịch vụ:</strong> <span>#2</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-transparent">
                                <strong>Công nghệ:</strong> <span>Máy siêu âm Piezotome</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-transparent">
                                <strong>Thời gian:</strong> <span>~30-45 phút</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-transparent">
                                <strong>Chi phí ước tính:</strong> <span class="fw-bold text-danger">250.000 VNĐ</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-transparent">
                                <strong>Định kỳ:</strong> <span>6 tháng/lần</span>
                            </li>
                        </ul>

                        <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking w-100">
                            <i class="fas fa-calendar-alt me-2"></i> Đặt lịch làm sạch
                        </a>
                    </div>

                    <div class="mt-4 card sidebar-card">
                        <h4 class="text-secondary fw-bold mb-3">Dịch vụ liên quan</h4>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><a href="/service_demo_list?id=1" class="text-decoration-none text-primary fw-bold">Khám tổng quát</a></li>
                            <li class="list-group-item"><a href="/service_demo_list?id=3" class="text-decoration-none text-primary fw-bold">Trám răng thẩm mỹ</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <hr class="my-5">

            <div class="text-center">
                <a href="/home" class="btn btn-outline-secondary btn-lg"><i class="fas fa-arrow-left me-2"></i> Quay lại</a>
            </div>

        </div>

    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>