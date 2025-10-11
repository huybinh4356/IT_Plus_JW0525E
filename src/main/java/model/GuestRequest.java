package model;

import java.sql.Timestamp;

public class GuestRequest {
    private int requestId;
    private String fullName;
    private String phone;
    private String email;
    private String cccd;
    private String address;
    private String message;
    private Timestamp createdAt;

    public GuestRequest() {}

    public GuestRequest(int requestId, String fullName, String phone, String email,
                        String cccd, String address, String message, Timestamp createdAt) {
        this.requestId = requestId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.cccd = cccd;
        this.address = address;
        this.message = message;
        this.createdAt = createdAt;
    }

    // Getter & Setter
    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
