<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Action_Service" %>
<%
    Action_Service service = (Action_Service) request.getAttribute("service");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật dịch vụ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            background-image: url('${pageContext.request.contextPath}/assets/images/img_1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        .container {
            max-width: 800px; /* Điều chỉnh max-width cho form cập nhật */
            width: 100%;
            padding-top: 50px;
            padding-bottom: 50px;
        }

        .card-form {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #007bff;
            z-index: 10;
            position: relative;
        }

        h1 {
            color: #007bff;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            font-size: 2rem; /* Điều chỉnh kích thước tiêu đề */
        }
        h1::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: #007bff;
            border-radius: 2px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            transition: all .2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 4px rgba(13,110,253,.15);
        }

        .btn-success {
            background: #007bff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: #0056b3;
            box-shadow: 0 6px 15px rgba(0, 123, 255, 0.4);
            transform: translateY(-1px);
        }
        .btn-secondary {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
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

<div class="container mt-4">
    <div class="card-form">
        <h1>Cập nhật dịch vụ</h1>

        <form action="ServiceServlet" method="post">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="<%= service.getService_id() %>"/>

            <div class="mb-3">
                <label class="form-label">Tên dịch vụ</label>
                <input type="text" name="service_name" class="form-control"
                       value="<%= service.getService_name() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Danh mục</label>
                <input type="text" name="category" class="form-control"
                       value="<%= service.getCategory() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Mô tả</label>
                <textarea name="description" class="form-control" rows="3" required><%= service.getDescription() %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Khách hàng mục tiêu</label>
                <input type="text" name="target_customer" class="form-control"
                       value="<%= service.getTarget_customer() %>"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Quy trình</label>
                <input type="text" name="process" class="form-control"
                       value="<%= service.getProcess() %>"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Công nghệ</label>
                <input type="text" name="technology" class="form-control"
                       value="<%= service.getTechnology() %>"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Thời gian</label>
                <input type="text" name="duration" class="form-control"
                       value="<%= service.getDuration() %>"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Chính sách bảo hành</label>
                <input type="text" name="warranty_policy" class="form-control"
                       value="<%= service.getWarranty_policy() %>"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" step="1000" name="price" class="form-control"
                       value="<%= service.getPrice() %>" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="is_active" class="form-select">
                    <option value="true" <%= service.isIs_active() ? "selected" : "" %>>Kích hoạt</option>
                    <option value="false" <%= !service.isIs_active() ? "selected" : "" %>>Ngừng hoạt động</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success me-2">Cập nhật</button>
            <a href="ServiceServlet?action=list" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>