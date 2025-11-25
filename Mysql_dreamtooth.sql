-- Xóa nếu có rồi tạo mới
DROP DATABASE IF EXISTS DreamToothDBDemo;
CREATE DATABASE DreamToothDBDemo;
USE DreamToothDBDemo;

-- Bảng chuyên ngành (cho bác sĩ)
CREATE TABLE Specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Bảng người dùng
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('Nam', 'Nữ') NOT NULL,
    cccd VARCHAR(20) UNIQUE,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    role_id INT NOT NULL,              
    specialty_id INT NULL,                -- Tham chiếu đến Specialties
    degree VARCHAR(100),
    position VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,       -- ✅ thêm cột này
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (specialty_id) REFERENCES Specialties(specialty_id)
);

-- Bảng dịch vụ
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    description TEXT,
    target_customer VARCHAR(100),
    process TEXT,
    technology TEXT,
    duration VARCHAR(50),
    warranty_policy TEXT,
    price DECIMAL(20,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng đăt lịch nhanh 
CREATE TABLE GuestRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    cccd VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng lịch hẹn
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_code VARCHAR(20) NOT NULL UNIQUE,
    patient_id INT,
    service_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('PENDING','CONFIRMED','COMPLETED','CANCELLED') DEFAULT 'PENDING',
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Bảng hồ sơ bệnh án
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES Users(user_id)
);

-- Bảng đánh giá
	CREATE TABLE Reviews (
		review_id INT AUTO_INCREMENT PRIMARY KEY,
		patient_id INT NOT NULL,
		service_id INT NULL,
		appointment_id INT NULL, -- ✅ cho phép NULL để linh hoạt hơn
		rating TINYINT NOT  NULL CHECK (rating BETWEEN 1 AND 5),
		comment TEXT,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (patient_id) REFERENCES Users(user_id),
		FOREIGN KEY (service_id) REFERENCES Services(service_id),
		FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
	);
DROP TABLE IF EXISTS Wishlist;

CREATE TABLE Wishlist (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    service_id INT NOT NULL,
	notes TEXT NULL,  
    add_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (patient_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
	UNIQUE KEY uq_patient_service (patient_id, service_id)
);
-- Bảng thông tin phòng khám
CREATE TABLE ClinicInfo (
    clinic_id INT PRIMARY KEY DEFAULT 1,
    name VARCHAR(100) DEFAULT 'DreamTooth',
    address VARCHAR(255) NOT NULL,
    hostline VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    working_hours VARCHAR(100),
    description TEXT,
    logo VARCHAR(255)
);

INSERT INTO Specialties (name, description) VALUES
('Nha khoa Phục hình', 'Chuyên phục hình răng như cầu răng, mão răng, hàm giả tháo lắp và cố định'),
('Chỉnh nha', 'Chuyên điều trị chỉnh hình răng và hàm, sử dụng các khí cụ như mắc cài, khay trong'),
('Nha khoa Trẻ em', 'Chuyên chăm sóc và điều trị các vấn đề răng miệng cho trẻ em'),
('Nội nha', 'Chuyên điều trị tủy răng và các bệnh lý liên quan đến tủy'),
('Nha chu', 'Chuyên chẩn đoán và điều trị các bệnh lý quanh răng như viêm nướu, viêm nha chu'),
('Phẫu thuật Răng Hàm Mặt', 'Chuyên thực hiện các phẫu thuật như nhổ răng khó, cấy ghép implant, phẫu thuật hàm'),
('Cấy ghép Implant', 'Chuyên phục hình răng mất bằng trụ implant và mão răng sứ'),
('Nha khoa Thẩm mỹ', 'Chuyên các dịch vụ thẩm mỹ như tẩy trắng răng, dán sứ veneer, phục hình thẩm mỹ'),
('Gây mê Hồi sức Răng Hàm Mặt', 'Chuyên gây mê và quản lý đau trong các thủ thuật Răng Hàm Mặt'),
('Nha khoa Dự phòng', 'Chuyên các biện pháp phòng ngừa bệnh răng miệng và giáo dục sức khỏe răng miệng'),
('Răng giả Toàn bộ và Từng phần', 'Chuyên thiết kế và lắp các hàm giả toàn bộ hoặc từng phần'),
('Chẩn đoán Răng Hàm Mặt', 'Chuyên chẩn đoán hình ảnh và bệnh lý Răng Hàm Mặt qua X-quang và các kỹ thuật khác'),
('Nha khoa Phục hồi chức năng', 'Chuyên phục hồi chức năng nhai và thẩm mỹ cho bệnh nhân'),
('Điều trị Rối loạn Khớp thái dương hàm', 'Chuyên chẩn đoán và điều trị các rối loạn khớp thái dương hàm và cơ nhai'),
('Nha khoa Cộng đồng', 'Chuyên chăm sóc sức khỏe răng miệng cho cộng đồng và các chương trình y tế công cộng');
INSERT INTO Services (service_name, category, description, target_customer, process, technology, duration, warranty_policy, price, is_active)
VALUES
-- 1. Khám tổng quát răng miệng
('Khám tổng quát răng miệng', 'Khám', 'Kiểm tra tình trạng răng miệng, nướu, phát hiện sâu răng và bệnh lý nha chu', 
 'Mọi đối tượng', 'Khám lâm sàng, chụp X-quang', 'Máy X-quang kỹ thuật số', '30 phút', 'Không áp dụng', 150000, TRUE),

-- 2. Cạo vôi răng và đánh bóng
('Cạo vôi răng và đánh bóng', 'Điều trị', 'Loại bỏ cao răng, mảng bám và làm sạch bề mặt răng', 
 'Người lớn và thanh thiếu niên', 'Cạo vôi siêu âm, đánh bóng', 'Máy cạo vôi siêu âm', '40 phút', '6 tháng tái khám miễn phí', 300000, TRUE),

-- 3. Trám răng thẩm mỹ
('Trám răng thẩm mỹ', 'Phục hồi', 'Phục hồi răng sâu hoặc mẻ bằng vật liệu Composite màu răng', 
 'Khách hàng có răng sâu nhẹ, mẻ', 'Làm sạch lỗ sâu, trám vật liệu', 'Composite quang trùng hợp', '45 phút', 'Bảo hành 1 năm', 400000, TRUE),

-- 4. Điều trị tủy răng
('Điều trị tủy răng', 'Điều trị', 'Loại bỏ tủy viêm và trám bít ống tủy', 
 'Khách hàng bị viêm tủy', 'Mở tủy, làm sạch, trám bít', 'Máy nội nha X-Smart', '2-3 lần hẹn (60 phút mỗi lần)', 'Bảo hành 2 năm', 1200000, TRUE),

-- 5. Nhổ răng thường
('Nhổ răng thường', 'Tiểu phẫu', 'Nhổ các răng lung lay hoặc cần loại bỏ do sâu', 
 'Mọi đối tượng', 'Gây tê, nhổ răng bằng kìm chuyên dụng', 'Dụng cụ nha khoa chuẩn', '30 phút', 'Không áp dụng', 250000, TRUE),

-- 6. Nhổ răng khôn mọc lệch
('Nhổ răng khôn mọc lệch', 'Tiểu phẫu', 'Loại bỏ răng khôn mọc ngầm hoặc lệch gây đau nhức', 
 'Người lớn', 'Chụp X-quang, gây tê, tiểu phẫu', 'Máy X-quang Cone Beam CT 3D', '60-90 phút', 'Bảo hành 1 tuần tái khám miễn phí', 1500000, TRUE),

-- 7. Tẩy trắng răng tại phòng khám
('Tẩy trắng răng', 'Thẩm mỹ', 'Sử dụng thuốc tẩy trắng kết hợp đèn plasma để làm sáng răng', 
 'Khách hàng muốn răng trắng hơn', 'Bôi thuốc, chiếu đèn plasma', 'Đèn plasma Beyond', '60 phút', 'Bảo hành 1 năm', 2000000, TRUE),

-- 8. Chỉnh nha niềng răng mắc cài kim loại
('Niềng răng mắc cài kim loại', 'Chỉnh nha', 'Điều chỉnh khớp cắn và làm đều răng bằng mắc cài kim loại', 
 'Thanh thiếu niên, người trưởng thành', 'Gắn mắc cài, dây cung, tái khám định kỳ', 'Mắc cài kim loại 3M', '18-24 tháng', 'Bảo hành trong suốt liệu trình', 25000000, TRUE),

-- 9. Chỉnh nha niềng răng Invisalign
('Niềng răng Invisalign', 'Chỉnh nha', 'Niềng răng trong suốt, tháo lắp dễ dàng', 
 'Khách hàng cần tính thẩm mỹ cao', 'Lấy dấu hàm, thiết kế khay Invisalign', 'Khay trong Invisalign', '12-24 tháng', 'Bảo hành trong suốt liệu trình', 80000000, TRUE),

-- 10. Làm răng sứ kim loại
('Làm răng sứ kim loại', 'Phục hình', 'Bọc răng sứ với lõi kim loại, thẩm mỹ vừa phải', 
 'Khách hàng có răng hư tổn nặng', 'Mài răng, lấy dấu, lắp mão sứ', 'Sứ kim loại Ceramco3', '2-3 buổi', 'Bảo hành 3 năm', 1500000, TRUE),

-- 11. Làm răng toàn sứ Zirconia
('Làm răng toàn sứ Zirconia', 'Phục hình', 'Bọc răng toàn sứ cao cấp, thẩm mỹ cao', 
 'Khách hàng yêu cầu cao về thẩm mỹ', 'Mài răng, lấy dấu, lắp răng Zirconia', 'Sứ Zirconia CAD/CAM', '2-3 buổi', 'Bảo hành 10 năm', 4000000, TRUE),

-- 12. Cấy ghép Implant đơn lẻ
('Cấy ghép Implant đơn lẻ', 'Implant', 'Thay thế 1 răng mất bằng trụ Implant và mão sứ', 
 'Người mất 1 răng', 'Cắm trụ Implant, chờ tích hợp xương, lắp mão sứ', 'Implant Straumann Thụy Sĩ', '3-6 tháng', 'Bảo hành trọn đời', 20000000, TRUE),

-- 13. Hàm tháo lắp bán phần
('Hàm tháo lắp bán phần', 'Phục hình', 'Làm hàm giả tháo lắp thay thế nhiều răng mất', 
 'Người già, người mất nhiều răng', 'Lấy dấu, thiết kế hàm, lắp thử', 'Nhựa dẻo và khung kim loại', '2-3 buổi', 'Bảo hành 1 năm', 3000000, TRUE),

-- 14. Hàm tháo lắp toàn phần
('Hàm tháo lắp toàn phần', 'Phục hình', 'Hàm giả thay thế toàn bộ răng', 
 'Người cao tuổi mất toàn bộ răng', 'Lấy dấu, thiết kế hàm toàn phần', 'Nhựa cứng Acrylic', '3 buổi', 'Bảo hành 1 năm', 5000000, TRUE),

-- 15. Điều trị viêm nha chu
('Điều trị viêm nha chu', 'Điều trị', 'Loại bỏ túi nha chu, làm sạch mảng bám dưới nướu', 
 'Người bị viêm nha chu', 'Cạo vôi sâu, xử lý nướu', 'Máy siêu âm và laser nha chu', '2-3 buổi', 'Bảo hành 6 tháng', 2000000, TRUE),

-- 16. Ghép xương trong Implant
('Ghép xương trong Implant', 'Implant', 'Ghép xương hàm cho trường hợp tiêu xương nặng', 
 'Người mất răng lâu năm', 'Mở nướu, ghép xương nhân tạo', 'Xương Bio-Oss', '3-6 tháng', 'Không áp dụng', 10000000, TRUE),

-- 17. Đính đá răng
('Đính đá răng', 'Thẩm mỹ', 'Đính đá trang trí trên răng', 
 'Khách hàng trẻ, yêu cầu thẩm mỹ', 'Gắn đá bằng keo nha khoa', 'Đá Swarovski và keo quang trùng hợp', '30 phút', 'Bảo hành 6 tháng', 800000, TRUE),

-- 18. Cắt nướu thẩm mỹ
('Cắt nướu thẩm mỹ', 'Thẩm mỹ', 'Điều chỉnh viền nướu để nụ cười hài hòa', 
 'Khách hàng có cười hở lợi', 'Gây tê, cắt nướu bằng laser', 'Laser nha khoa', '45 phút', 'Bảo hành 1 năm', 3000000, TRUE),

-- 19. Làm máng tẩy trắng tại nhà
('Máng tẩy trắng răng tại nhà', 'Thẩm mỹ', 'Cung cấp máng và thuốc tẩy trắng để dùng tại nhà', 
 'Khách hàng muốn răng trắng chủ động', 'Lấy dấu hàm, chế tác máng, hướng dẫn dùng', 'Gel tẩy trắng Opalescence', '1-2 tuần', 'Bảo hành 6 tháng', 1500000, TRUE),

-- 20. Khám và tư vấn chỉnh nha
('Khám và tư vấn chỉnh nha', 'Khám', 'Khám tổng quát và tư vấn kế hoạch chỉnh nha', 
 'Khách hàng có răng lệch lạc', 'Chụp X-quang, phân tích phim', 'Phần mềm V-Ceph 3D', '45 phút', 'Không áp dụng', 200000, TRUE);
INSERT INTO ClinicInfo (clinic_id, name, address, hostline, email, working_hours, description, logo)
VALUES 
(1, 'DreamTooth', '123 Nguyễn Trãi, Hà Nội', '0123456789', 'contact@dreamtooth.com', '8:00 - 20:00', 'Phòng khám nha khoa hiện đại, uy tín.', 'logo.png'),

(2, 'DreamTooth', '456 Lê Lợi, TP. Hồ Chí Minh', '0987654321', 'support@dreamtooth.vn', '9:00 - 21:00', 'Cơ sở chi nhánh phía Nam với trang thiết bị hiện đại.', 'logo.png');
INSERT INTO Users (
    username, 
    password_hash, 
    full_name, 
    dob, 
    gender, 
    cccd, 
    phone, 
    email, 
    address, 
    role_id, 
    specialty_id, 
    degree, 
    position, 
    is_active
) 
VALUES (
    'admin01', 
    '123456',  
    'Quản Trị', 
    '1990-01-01', 
    'Nam', 
    '001190000001', 
    '0901234567', 
    'admin@dreamtooth.com', 
    '123 Đường Quản Lý, Hà Nội', 
    1,          -- ROLE_ID = 1 (ADMIN)
    NULL,       -- ADMIN không cần Specialty
    'Thạc sĩ', 
    'Giám đốc Hệ thống', 
    TRUE
);
INSERT INTO Users 
(username, password_hash, full_name, dob, gender, cccd, phone, email, address, role_id, specialty_id, degree, position, is_active) 
VALUES
('doctor01', '123456', 'Nguyễn Văn A', '1980-05-12', 'Nam', '012345678901', '0912345678', 'doctor01@example.com', 'Hà Nội', 3, 1, 'Thạc sĩ Y học', 'Bác sĩ nội trú', TRUE),
('doctor02', '123456', 'Trần Thị B', '1985-08-21', 'Nữ', '012345678902', '0912345679', 'doctor02@example.com', 'TP.HCM', 3, 2, 'Tiến sĩ Y khoa', 'Trưởng khoa', TRUE),
('doctor03', '123456', 'Lê Văn C', '1979-01-15', 'Nam', '012345678903', '0987654321', 'doctor03@example.com', 'Đà Nẵng', 3, 3, 'Bác sĩ CKI', 'Bác sĩ điều trị', TRUE),
('doctor04', '123456', 'Phạm Thị D', '1990-03-10', 'Nữ', '012345678904', '0911122233', 'doctor04@example.com', 'Hải Phòng', 3, 1, 'Bác sĩ CKII', 'Phó khoa', TRUE),
('doctor05', '123456', 'Hoàng Văn E', '1982-07-19', 'Nam', '012345678905', '0933445566', 'doctor05@example.com', 'Cần Thơ', 3, 2, 'Tiến sĩ Y học', 'Giảng viên', TRUE),
('doctor06', '123456', 'Đỗ Thị F', '1988-12-25', 'Nữ', '012345678906', '0944556677', 'doctor06@example.com', 'Thanh Hóa', 3, 3, 'Thạc sĩ Y khoa', 'Bác sĩ điều trị', TRUE),
('doctor07', '123456', 'Ngô Văn G', '1975-11-30', 'Nam', '012345678907', '0955667788', 'doctor07@example.com', 'Huế', 3, 4, 'Bác sĩ CKII', 'Trưởng khoa', TRUE),
('doctor08', '123456', 'Bùi Thị H', '1992-04-07', 'Nữ', '012345678908', '0966778899', 'doctor08@example.com', 'Bắc Ninh', 3, 1, 'Thạc sĩ Y học', 'Bác sĩ nội trú', TRUE),
('doctor09', '123456', 'Phan Văn I', '1984-09-13', 'Nam', '012345678909', '0977889900', 'doctor09@example.com', 'Nghệ An', 3, 2, 'Tiến sĩ Y học', 'Phó khoa', TRUE),
('doctor10', '123456', 'Vũ Thị K', '1987-06-02', 'Nữ', '012345678910', '0988990011', 'doctor10@example.com', 'Nam Định', 3, 3, 'Bác sĩ CKI', 'Bác sĩ điều trị', TRUE);
INSERT INTO Appointments 
(appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note)
VALUES
('APPT001', 2, 1, '2025-10-01', '09:00:00', 'COMPLETED', 'Khám tổng quát định kỳ'),
('APPT002', 2, 2, '2025-10-02', '10:15:00', 'COMPLETED', 'Cạo vôi răng'),
('APPT003', 3, 3, '2025-10-03', '14:30:00', 'COMPLETED', 'Trám răng sâu nhẹ'),
('APPT004', 2, 4, '2025-10-04', '08:45:00', 'COMPLETED', 'Điều trị tủy răng hàm dưới'),
('APPT005', 2, 5, '2025-10-05', '11:00:00', 'COMPLETED', 'Nhổ răng hàm bị lung lay'),
('APPT006', 2, 6, '2025-10-06', '15:20:00', 'COMPLETED', 'Nhổ răng khôn mọc lệch'),
('APPT007', 2, 7, '2025-10-07', '09:30:00', 'COMPLETED', 'Tẩy trắng răng tại phòng'),
('APPT008', 9, 8, '2025-10-08', '13:10:00', 'COMPLETED', 'Tư vấn niềng răng kim loại'),
('APPT009', 10, 9, '2025-10-09', '16:00:00', 'COMPLETED', 'Khám Invisalign'),
('APPT010', 11, 10, '2025-10-10', '10:50:00', 'COMPLETED', 'Làm răng sứ kim loại');
-- Thêm 10 hồ sơ bệnh án (MedicalRecords)
INSERT INTO MedicalRecords (patient_id, appointment_id, diagnosis, treatment, notes)
VALUES
(2, 1, 'Cảm cúm nhẹ', 'Uống thuốc hạ sốt và nghỉ ngơi', 'Bệnh nhân đáp ứng tốt'),
(3, 2, 'Đau dạ dày', 'Kê đơn thuốc 7 ngày', 'Cần tái khám sau 1 tuần'),
(4, 3, 'Viêm họng', 'Kháng sinh và nước muối súc miệng', 'Theo dõi 3 ngày'),
(5, 4, 'Đau đầu kinh niên', 'Cho thuốc giảm đau nhẹ', 'Gợi ý kiểm tra chuyên sâu'),
(6, 5, 'Dị ứng thời tiết', 'Thuốc kháng histamine', 'Tránh tác nhân gây dị ứng'),
(7, 6, 'Đau khớp gối', 'Vật lý trị liệu + thuốc giảm đau', 'Hẹn tái khám 10 ngày'),
(8, 7, 'Viêm mũi dị ứng', 'Xịt mũi + thuốc uống', 'Tình trạng ổn định'),
(9, 8, 'Rối loạn tiêu hóa', 'Chế độ ăn nhẹ + men tiêu hóa', 'Theo dõi phản ứng thuốc'),
(10, 9, 'Mất ngủ tạm thời', 'Thuốc an thần nhẹ', 'Khuyên bệnh nhân nghỉ ngơi'),
(11, 10, 'Căng cơ vai', 'Xoa bóp + thuốc giảm đau', 'Cải thiện sau điều trị');

INSERT INTO Appointments (appointment_code, patient_id, service_id, appointment_date, appointment_time, status, note) 
VALUES 
('APPT20250501A', 2, 1, '2025-05-01', '09:00:00', 'COMPLETED', 'Lịch hẹn đã hoàn thành dịch vụ làm sạch răng.'),
('APPT20250515B', 2, 2, '2025-05-15', '14:30:00', 'CONFIRMED', 'Xác nhận lịch hẹn khám định kỳ.'),
('APPT20250522C', 2, 3, '2025-05-22', '10:15:00', 'PENDING', 'Yêu cầu dịch vụ niềng răng cơ bản.'),
('APPT20250605D', 2, 4, '2025-06-05', '16:00:00', 'CANCELLED', 'Bệnh nhân hủy lịch hẹn do bận đột xuất.'),
('APPT20250618E', 2, 1, '2025-06-18', '11:30:00', 'COMPLETED', 'Tái khám sau khi trám răng.'),
('APPT20250701F', 2, 5, '2025-07-01', '08:45:00', 'CONFIRMED', 'Khám và tư vấn phục hình răng sứ.'),
('APPT20250710G', 2, 2, '2025-07-10', '13:00:00', 'PENDING', 'Lịch hẹn cho trẻ em đi kèm.'),
('APPT20250725H', 2, 6, '2025-07-25', '17:45:00', 'COMPLETED', 'Dịch vụ tẩy trắng răng nhanh.'),
('APPT20250808I', 2, 3, '2025-08-08', '09:30:00', 'CONFIRMED', 'Kiểm tra tiến độ niềng răng (tháng thứ 3).'),
('APPT20250820J', 2, 7, '2025-08-20', '15:00:00', 'PENDING', 'Yêu cầu nhổ răng khôn (mới).');
INSERT INTO Reviews (patient_id, service_id, appointment_id, rating, comment) VALUES 
(2, 1, 1, 5, 'Dịch vụ làm sạch răng rất chuyên nghiệp và nhanh chóng. Bác sĩ thân thiện.'),
(2, 1, 5, 4, 'Tái khám sau trám răng ổn, không còn cảm giác đau nhức. Hài lòng với chất lượng.'),
(2, 6, 8, 5, 'Kết quả tẩy trắng vượt mong đợi. Không bị ê buốt nhiều.'),

(2, 5, 6, 4, 'Bác sĩ tư vấn rất kỹ lưỡng về phục hình răng sứ, giúp tôi yên tâm hơn.'),
(2, 3, 9, 3, 'Tiến độ niềng răng có vẻ hơi chậm so với dự kiến, cần theo dõi thêm.'),

(2, 2, NULL, 5, 'Khám định kỳ rất chi tiết, phòng khám sạch sẽ.'),
(2, 3, NULL, 4, 'Dịch vụ chỉnh nha có nhiều gói lựa chọn, nhân viên tư vấn nhiệt tình.'),

(2, NULL, 2, 5, 'Quy trình đặt lịch hẹn rất đơn giản qua app. Xác nhận nhanh chóng.'),
(2, NULL, 7, 3, 'Phòng chờ đông, phải đợi hơi lâu so với giờ hẹn đã đặt.'),

(2, 7, 10, 5, 'Dù là nhổ răng khôn nhưng bác sĩ làm rất nhẹ nhàng, không đau. Hồi phục nhanh.');
