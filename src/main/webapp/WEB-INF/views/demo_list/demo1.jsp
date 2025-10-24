<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi Tiết Dịch Vụ #${requestScope.currentServiceId}: Khám tổng quát Răng miệng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body {
      background-color: #f0f2f5; /* Nền xám nhạt để box trắng nổi bật */
      font-family: 'Inter', sans-serif;
      font-size: 1.1rem;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;

    }
    .section-title { font-size: 2.2rem; font-weight: 700; color: #007bff; margin-bottom: 30px; }

    .detail-hero-section {
      background-image: url('${pageContext.request.contextPath}/assets/images/img.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      color: white;
      padding: 100px 0;
      min-height: 400px;
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
      background-color: rgba(0, 0, 0, 0.2);
      z-index: -1;
    }
    .detail-hero-title {
      font-size: 3.5rem;
      font-weight: 900;
      margin-bottom: 5px;
      color: #ffe082;
    }
    .detail-hero-subtitle {
      font-size: 1.5rem;
      opacity: 0.9;
      margin-bottom: 40px;
      font-weight: 500;
    }

    /* NÚT ĐẶT LỊCH NỔI BẬT */
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

    /* --- BOX NỀN LỚN CHO NỘI DUNG --- */
    .content-box {
      background-color: #ffffff; /* Nền trắng */
      padding: 40px; /* Khoảng cách bên trong */
      border-radius: 12px; /* Bo góc mềm mại */
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1); /* Đổ bóng chuyên nghiệp */
      margin-top: -50px; /* Kéo lên che phủ một phần banner */
      position: relative;
      z-index: 10;
    }

    .card-feature {
      background-color: #fff;
      border-left: 5px solid #007bff;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
      padding: 25px;
      transition: transform 0.3s, box-shadow 0.3s;
    }
    .card-feature:hover { transform: translateY(-5px); box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12); }
    .feature-icon-large { font-size: 2rem; color: #007bff; margin-right: 15px; }
    .list-group-item.highlighted { background-color: #e9f5ff; border-left: 4px solid #007bff; }
    .sidebar-card {
      background-color: #f8f9fa;
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
      padding: 30px;
    }
    .table-primary { background-color: #007bff !important; color: white; }
  </style>
</head>
<body>

<div class="detail-hero-section text-center">
  <div class="container-xl">
    <h1 class="detail-hero-title">KHÁM RĂNG TỔNG QUÁT</h1>
    <p class="detail-hero-subtitle">Bước đầu đơn giản, hiệu quả trọn đời cho sức khỏe răng miệng</p>
    <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking">
      <i class="fas fa-calendar-alt me-2"></i> Đặt lịch Khám ngay
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
          <li class="breadcrumb-item active" aria-current="page">Khám tổng quát</li>
        </ol>
      </nav>

      <div class="row g-5">
        <div class="col-lg-8">

          <h2 class="section-title">1. Ưu Điểm Tuyệt Vời Của Khám Tổng Quát</h2>
          <div class="row g-3 mb-4">
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-search feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Phát hiện sớm bệnh lý</h5>
                    <p class="card-text text-muted">Khi chưa biểu hiện rõ triệu chứng.</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-hand-holding-usd feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Tiết kiệm chi phí</h5>
                    <p class="card-text text-muted">Nhờ can thiệp sớm, tránh điều trị chuyên sâu.</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-shield-alt feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Bảo vệ răng thật lâu dài</h5>
                    <p class="card-text text-muted">Giảm nguy cơ mất răng sớm.</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card card-feature h-100">
                <div class="card-body d-flex align-items-start">
                  <i class="fas fa-user-check feature-icon-large"></i>
                  <div>
                    <h5 class="card-title fw-bold text-dark">Kế hoạch điều trị cá nhân hóa</h5>
                    <p class="card-text text-muted">Theo tình trạng riêng của từng người.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <hr class="my-5">

          <h2 class="section-title">2. Ai Nên Khám Tổng Quát Và Tần Suất</h2>
          <div class="card bg-light p-4 mb-4 border-0 shadow-sm">
            <h5 class="text-primary fw-bold mb-3"><i class="fas fa-child me-2"></i> Trẻ em</h5>
            <p>Từ **3 tuổi** trở lên, khám tổng quát **6 tháng/lần** để kiểm soát sâu răng sữa, hướng mọc răng vĩnh viễn.</p>
            <hr>
            <h5 class="text-primary fw-bold mb-3"><i class="fas fa-user-friends me-2"></i> Người trưởng thành</h5>
            <p>Duy trì khám **6 tháng/lần**, hoặc **3 tháng** nếu có tiền sử viêm nha chu, nghiến răng, hút thuốc.</p>
            <hr>
            <h5 class="text-primary fw-bold mb-3"><i class="fas fa-baby me-2"></i> Phụ nữ mang thai</h5>
            <p>Nên khám trong **3 tháng giữa** thai kỳ để kiểm soát viêm nướu thai kỳ, tránh ảnh hưởng sức khỏe toàn thân.</p>
          </div>

          <hr class="my-5">

          <h2 class="section-title">3. Quy Trình Khám & Công Nghệ</h2>
          <p>Tùy từng trường hợp, quy trình khám tổng quát tại Friendly Dentists bao gồm:</p>
          <ol class="list-group list-group-numbered shadow-sm mb-4">
            <li class="list-group-item highlighted">**Khám lâm sàng:** Kiểm tra toàn bộ răng, nướu, khớp cắn và niêm mạc miệng.</li>
            <li class="list-group-item highlighted">**Phân tích chuyên sâu:** Phát hiện răng mòn, răng lệch trục, đánh giá nguy cơ sâu răng, viêm tủy.</li>
            <li class="list-group-item highlighted">**Chụp phim X-quang (nếu cần):** Sử dụng **Máy X-quang kỹ thuật số** để phát hiện các vấn đề ẩn.</li>
            <li class="list-group-item highlighted">**Tư vấn cá nhân hóa:** Đưa ra kế hoạch chăm sóc và điều trị cụ thể.</li>
          </ol>

          <h3 class="sub-section-title text-warning fw-bold"><i class="fas fa-info-circle me-2"></i> Lưu ý trước khi Khám</h3>
          <ul class="list-unstyled">
            <li class="d-flex align-items-start mb-2"><span class="feature-icon me-3 text-warning"><i class="fas fa-exclamation-triangle"></i></span> **Đánh răng** trước khi đến nhưng **không súc miệng bằng nước màu hoặc nước muối**.</li>
            <li class="d-flex align-items-start mb-2"><span class="feature-icon me-3 text-warning"><i class="fas fa-exclamation-triangle"></i></span> Ghi chú các biểu hiện bất thường (đau – ê buốt – sưng) để bác sĩ dễ tư vấn.</li>
            <li class="d-flex align-items-start mb-2"><span class="feature-icon me-3 text-warning"><i class="fas fa-exclamation-triangle"></i></span> Giữ tâm lý thoải mái – khám không đau.</li>
          </ul>

          <hr class="my-5">

          <h2 class="section-title">4. Khám Tổng Quát vs Khám Cấp Cứu</h2>
          <div class="table-responsive">
            <table class="table table-bordered table-striped shadow-sm">
              <thead class="table-primary">
              <tr>
                <th>Yếu tố</th>
                <th>Khám tổng quát</th>
                <th>Khám khi có triệu chứng cấp cứu</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td>**Tâm lý**</td>
                <td>Chủ động, thoải mái</td>
                <td>Lo lắng, gấp gáp</td>
              </tr>
              <tr>
                <td>**Mục tiêu**</td>
                <td>Dự phòng, phát hiện sớm</td>
                <td>Giảm đau, điều trị tạm thời</td>
              </tr>
              <tr>
                <td>**Chi phí**</td>
                <td>Thường thấp hơn nếu làm định kỳ</td>
                <td>Có thể tốn kém hơn vì bệnh tiến triển</td>
              </tr>
              <tr>
                <td>**Hiệu quả lâu dài**</td>
                <td>Cao – ít biến chứng</td>
                <td>Hạn chế nếu bệnh đã nặng</td>
              </tr>
              </tbody>
            </table>
          </div>

        </div>

        <div class="col-lg-4">
          <div class="card sidebar-card sticky-top" style="top: 20px;">
            <h4 class="text-center text-primary mb-4 fw-bold">Chi Phí & Thông Tin Nhanh</h4>
            <ul class="list-group list-group-flush mb-4">
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Thể loại:</strong> <span>Khám</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Công nghệ:</strong> <span>Máy X-quang Kỹ thuật số</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Thời gian:</strong> <span>~30 phút</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Chi phí ước tính:</strong> <span class="fw-bold text-danger">150.000 VNĐ</span>
              </li>
              <li class="list-group-item d-flex justify-content-between bg-transparent">
                <strong>Chính sách:</strong> <span>Không áp dụng bảo hành</span>
              </li>
            </ul>

            <a href="<c:url value='/guest-requests?action=addForm'/>" class="btn btn-booking w-100">
              <i class="fas fa-calendar-alt me-2"></i> Đặt lịch Khám ngay
            </a>
          </div>

          <div class="mt-4 card sidebar-card">
            <h4 class="text-secondary fw-bold mb-3">Liên kết Gợi ý</h4>
            <ul class="list-group list-group-flush">
              <li class="list-group-item"><a href="/service_demo_list?id=2" class="text-decoration-none text-primary fw-bold">Vệ sinh vôi răng</a></li>
              <li class="list-group-item"><a href="/service_demo_list?id=3" class="text-decoration-none text-primary fw-bold">Trám răng thẩm mỹ</a></li>
              <li class="list-group-item"><a href="/service_demo_list?id=4" class="text-decoration-none text-primary fw-bold">Tẩy trắng răng</a></li>
            </ul>
          </div>
        </div>
      </div>

      <hr class="my-5">

      <div class="text-center">
        <a href="/home" class="btn btn-outline-secondary btn-lg"><i class="fas fa-arrow-left me-2"></i> Quay lại</a>
      </div>

    </div> </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>