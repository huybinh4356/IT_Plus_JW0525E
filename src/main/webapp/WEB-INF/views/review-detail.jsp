<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chi Tiết Đánh Giá #${review.review_id}</title>
  <!-- ĐÃ THÊM BOOTSTRAP CDN ĐỂ KÍCH HOẠT CÁC CLASS UTILITY (d-flex, mt-4, ml-3) -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

    /* CSS tùy chỉnh từ yêu cầu của bạn */
    body {
      background-color: #f0f8ff;
      margin: 0;
      font-family: 'Poppins', sans-serif;
      color: #333;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      height: auto;
    }

    .card-form {
      background: #ffffff;
      padding: 0;
      border-radius: 12px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
      border: none;
      transition: box-shadow 0.3s ease;
      z-index: 10;
      position: relative;
      max-width: 800px;
      width: 100%;
    }

    .card-header {
      background-color: #007bff !important;
      border-bottom: none;
      border-radius: 12px 12px 0 0;
      padding: 20px 30px;
    }

    h3 {
      font-weight: 700;
      margin-bottom: 0;
      color: white; /* Đảm bảo tiêu đề trong header màu trắng */
    }

    .card-body {
      padding: 30px;
    }

    /* DL styles for detail viewing */
    .detail-row dt {
      font-weight: 600;
      color: #495057;
      margin-bottom: 15px;
      width: 150px;
    }
    .detail-row dd {
      margin-bottom: 15px;
      font-weight: 500;
      color: #343a40;
      flex-grow: 1; /* Cho phép nội dung DD mở rộng */
    }
    .detail-row {
      display: flex;
      flex-wrap: wrap;
      margin-bottom: 0;
      padding: 10px 0;
      border-bottom: 1px dashed #eee; /* Đường phân cách nhẹ */
    }
    .detail-row:last-of-type {
      border-bottom: none;
    }
    /* Loại bỏ margin-right không cần thiết cho flex items */
    .detail-row > * {
      margin-right: 0;
    }

    .section-title {
      border-bottom: 2px solid #e9ecef;
      padding-bottom: 5px;
      margin-top: 20px;
      margin-bottom: 15px;
      color: #007bff;
      font-weight: 600;
    }

    /* Custom buttons */
    .btn-custom {
      background-color: #007bff;
      border: none;
      color: #fff;
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
      transition: all 0.3s ease;
      text-decoration: none; /* Quan trọng cho thẻ <a> */
      display: inline-block;
    }
    .btn-custom:hover {
      background-color: #0056b3;
      box-shadow: 0 6px 12px rgba(0, 123, 255, 0.3);
      color: #fff;
    }

    .btn-secondary-custom {
      background-color: #6c757d;
      border: none;
      color: #fff;
      border-radius: 8px;
      padding: 10px 25px;
      font-weight: 600;
      box-shadow: 0 4px 8px rgba(108, 117, 125, 0.2);
      transition: all 0.3s ease;
      text-decoration: none; /* Quan trọng cho thẻ <a> */
      display: inline-block;
    }
    .btn-secondary-custom:hover {
      background-color: #5a6268;
      box-shadow: 0 6px 12px rgba(108, 117, 125, 0.3);
      color: #fff;
    }

    .rating-stars {
      color: gold;
      font-size: 1.4em;
    }

    .comment-box {
      border: 1px solid #ced4da;
      padding: 15px;
      border-radius: 8px;
      background-color: #f8f9fa;
      white-space: pre-wrap;
      line-height: 1.6;
      margin-top: 5px;
    }

    /* Background Shapes */
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

<div class="card-form">
  <c:if test="${review != null}">
    <div class="card-header">
      <h3>Chi Tiết Đánh Giá Số: ${review.review_id}</h3>
    </div>

    <div class="card-body">

      <h5 class="section-title">Thông Tin Cơ Bản</h5>

      <dl>
        <div class="detail-row">
          <dt>ID Bệnh nhân:</dt>
          <dd>
            <c:choose>
              <c:when test="${review.patient != null && review.patient.user_id != null}">
                ${review.patient.user_id}
              </c:when>
              <c:otherwise>
                <em>Không rõ</em>
              </c:otherwise>
            </c:choose>
          </dd>
        </div>

        <div class="detail-row">
          <dt>ID Dịch vụ:</dt>
          <dd>
            <c:choose>
              <c:when test="${review.service != null && review.service.service_id != null}">
                ${review.service.service_id}
              </c:when>
              <c:otherwise>
                <em>Không áp dụng</em>
              </c:otherwise>
            </c:choose>
          </dd>
        </div>

        <div class="detail-row">
          <dt>ID Lịch hẹn:</dt>
          <dd>
            <c:choose>
              <c:when test="${review.appointment != null && review.appointment.appointment_id != null}">
                ${review.appointment.appointment_id}
              </c:when>
              <c:otherwise>
                <em>Không áp dụng</em>
              </c:otherwise>
            </c:choose>
          </dd>
        </div>

        <div class="detail-row">
          <dt>Xếp hạng:</dt>
          <dd>
            <span class="rating-stars">
              <c:forEach begin="1" end="${review.rating}">★</c:forEach>
              <c:forEach begin="${review.rating + 1}" end="5">☆</c:forEach>
            </span>
            (${review.rating}/5)
          </dd>
        </div>

        <div class="detail-row">
          <dt>Ngày tạo:</dt>
          <dd>${review.created_at}</dd>
        </div>
      </dl>

      <h5 class="section-title">Nội dung Đánh Giá</h5>
      <div class="comment-box">${review.comment}</div>

      <div class="d-flex justify-content-start mt-4">
        <!-- Đã ẩn nút "Sửa Đánh Giá" theo yêu cầu -->
        <a href="reviews?action=list" class="btn-custom">Quay lại Danh Sách</a>
      </div>

    </div>
  </c:if>
  <c:if test="${review == null}">
    <div class="card-header">
      <h3>Lỗi</h3>
    </div>
    <div class="card-body">
      <p>Không tìm thấy thông tin đánh giá.</p>
      <a href="reviews?action=list" class="btn-custom">Quay lại Danh Sách</a>
    </div>
  </c:if>
</div>
</body>
</html>
