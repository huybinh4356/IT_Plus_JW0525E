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
