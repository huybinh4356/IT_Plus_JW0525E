package model;

import java.time.LocalDateTime;

public class Reviews {
    private int review_id;
    private User patient;               // Object User
    private Action_Service service;     // Object Action_Service
    private Appointments appointment;    // Object Appointment
    private int rating;
    private String comment;
    private LocalDateTime created_at;

    public Reviews() {
    }

    public Reviews(int review_id, User patient, Action_Service service, Appointments appointment,
                   int rating, String comment, LocalDateTime created_at) {
        this.review_id = review_id;
        this.patient = patient;
        this.service = service;
        this.appointment = appointment;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
    }

    // ==================== Getters & Setters ====================
    public int getReview_id() {
        return review_id;
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public User getPatient() {
        return patient;
    }

    public void setPatient(User patient) {
        this.patient = patient;
    }

    public Action_Service getService() {
        return service;
    }

    public void setService(Action_Service service) {
        this.service = service;
    }

    public Appointments getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointments appointment) {
        this.appointment = appointment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}
