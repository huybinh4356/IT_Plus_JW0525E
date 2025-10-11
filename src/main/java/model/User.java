package model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class User implements Serializable {
    private int user_id;
    private String username;
    private String password_hash;
    private String full_name;
    private LocalDate dob; // Giữ LocalDate
    private String gender;
    private String cccd;
    private String phone;
    private String email;
    private String address;
    private int role_id; // Đã sửa từ 'role'
    private Specialties specialty;
    private String degree;
    private String position;
    private boolean is_active;
    private LocalDateTime created_at; // Giữ LocalDateTime

    // THUỘC TÍNH MỚI DÀNH CHO HIỂN THỊ TRÊN JSP (đã định dạng)
    private String formattedDob;
    private String formattedCreatedAt;

    public User() {
    }

    // Getters and Setters

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword_hash() { return password_hash; }
    public void setPassword_hash(String password_hash) { this.password_hash = password_hash; }

    public String getFull_name() { return full_name; }
    public void setFull_name(String full_name) { this.full_name = full_name; }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public int getRole_id() { return role_id; }
    public void setRole_id(int role_id) { this.role_id = role_id; }

    public Specialties getSpecialty() { return specialty; }
    public void setSpecialty(Specialties specialty) { this.specialty = specialty; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public boolean isIs_active() { return is_active; }
    public void setIs_active(boolean is_active) { this.is_active = is_active; }

    public LocalDateTime getCreated_at() { return created_at; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }

    // GETTERS/SETTERS CHO THUỘC TÍNH ĐỊNH DẠNG MỚI
    public String getFormattedDob() { return formattedDob; }
    public void setFormattedDob(String formattedDob) { this.formattedDob = formattedDob; }

    public String getFormattedCreatedAt() { return formattedCreatedAt; }
    public void setFormattedCreatedAt(String formattedCreatedAt) { this.formattedCreatedAt = formattedCreatedAt; }
}