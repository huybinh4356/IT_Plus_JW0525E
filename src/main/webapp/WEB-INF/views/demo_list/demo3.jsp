<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi Tiết Dịch Vụ #${requestScope.currentServiceId}: Trám răng Thẩm mỹ</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    /* CSS Chung cho Trang Chi Tiết (nhất quán với demo1.jsp) */
    body { background-color: #f0f2f5; font-family: 'Inter', sans-serif; font-size: 1.1rem; }
    .section-title { font-size: 2.2rem; font-weight: 700; color: #007bff; margin-bottom: 30px;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }


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
    <h1 class="detail-hero-title">TRÁM RĂNG THẨM MỸ</h1>
    <p class="detail-hero-subtitle">Khôi phục răng sứt mẻ, sâu, bảo vệ tủy răng bằng vật liệu composite</p>
    <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking">
      <i class="fas fa-calendar-alt me-2"></i> Đặt lịch Trám răng
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
          <li class="breadcrumb-item active" aria-current="page">Trám răng thẩm mỹ</li>
        </ol>
      </nav>

      <div class="row g-5">
        <div class="col-lg-8">

          <h2 class="section-title">1. Trám răng Composite là gì?</h2>
          <p>Trám răng (Hàn răng) sử dụng vật liệu **Composite** có màu sắc tương đồng với răng thật để lấp đầy các lỗ sâu, vết nứt, hoặc phục hồi hình dáng ban đầu của răng bị sứt mẻ. Đây là phương pháp bảo tồn răng hiệu quả và thẩm mỹ.</p>

          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-palette feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Tính thẩm mỹ cao</h5>
                    <p class="card-text text-muted">Màu sắc giống răng tự nhiên, khó nhận biết.</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-microscope feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Bảo tồn tối đa</h5>
                    <p class="card-text text-muted">Chỉ cần loại bỏ phần sâu/hỏng, giữ lại mô răng khỏe.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <hr class="my-5">

          <h2 class="section-title">2. Quy trình Trám răng Đạt chuẩn</h2>
          <p>Quy trình được thực hiện nhanh chóng, không đau, và đảm bảo độ bền tối đa:</p>
          <ol class="list-group list-group-numbered shadow-sm mb-4">
            <li class="list-group-item highlighted">**Gây tê và làm sạch:** Vệ sinh khoang miệng và gây tê (nếu cần). Loại bỏ hoàn toàn mô răng bị sâu.</li>
            <li class="list-group-item highlighted">**Tạo hình và Trám:** Bác sĩ đặt vật liệu composite vào lỗ sâu theo từng lớp, tạo hình và chiếu đèn Laser làm cứng.</li>
            <li class="list-group-item highlighted">**Chỉnh khớp cắn:** Điều chỉnh miếng trám để không gây cộm khi ăn nhai.</li>
            <li class="list-group-item highlighted">**Đánh bóng:** Giúp bề mặt miếng trám láng mịn, giảm khả năng bám màu.</li>
          </ol>

          <hr class="my-5">

          <h2 class="section-title">3. Các trường hợp nên Trám răng</h2>
          <div class="card bg-light p-4 mb-4 border-0 shadow-sm">
            <ul class="list-unstyled">
              <li class="mb-2"><i class="fas fa-tooth me-2 text-primary"></i> Răng bị sâu, tạo thành lỗ nhỏ.</li>
              <li class="mb-2"><i class="fas fa-tooth me-2 text-primary"></i> Răng bị nứt, vỡ, sứt mẻ do tai nạn hoặc va chạm.</li>
              <li class="mb-2"><i class="fas fa-tooth me-2 text-primary"></i> Răng bị mòn cổ chân răng gây ê buốt.</li>
              <li class="mb-2"><i class="fas fa-tooth me-2 text-primary"></i> Muốn đóng khe hở giữa hai răng cửa (Trám khe thưa).</li>
            </ul>
          </div>

        </div>

        <div class="col-lg-4">
          <div class="card sidebar-card sticky-top" style="top: 20px;">
            <h4 class="text-center text-primary mb-4 fw-bold">Chi Phí & Thông Tin Nhanh</h4>
            <ul class="list-group list-group-flush mb-4">
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>ID Dịch vụ:</strong> <span>#3</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Vật liệu:</strong> <span>Composite Quang trùng hợp</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Thời gian:</strong> <span>~20-30 phút/răng</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Chi phí ước tính:</strong> <span class="fw-bold text-danger">350.000 - 500.000 VNĐ</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Bảo hành:</strong> <span>6 tháng - 1 năm</span>
              </li>
            </ul>

            <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking w-100">
              <i class="fas fa-calendar-alt me-2"></i> Đặt lịch Trám răng
            </a>
          </div>

          <div class="mt-4 card sidebar-card">
            <h4 class="text-secondary fw-bold mb-3">Dịch vụ liên quan</h4>
            <ul class="list-group list-group-flush">
              <li class="list-group-item"><a href="/service_demo_list?id=1" class="text-decoration-none text-primary fw-bold">Khám tổng quát</a></li>
              <li class="list-group-item"><a href="/service_demo_list?id=4" class="text-decoration-none text-primary fw-bold">Tẩy trắng răng</a></li>
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