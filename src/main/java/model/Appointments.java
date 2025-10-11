package model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

public class Appointments {

    private int appointment_id;
    private String appointment_code;

    private User patient_id;
    private Action_Service service_id;

    private LocalDate appointment_date;
    private LocalTime appointment_time;
    private String status;
    private String note;
    private LocalDateTime created_at;


    public Appointments() {
    }

    // Constructor đầy đủ (trừ các trường tự sinh như ID và created_at)
    public Appointments(String appointment_code, User patient_id, Action_Service service_id, LocalDate appointment_date, LocalTime appointment_time, String status, String note) {
        this.appointment_code = appointment_code;
        this.patient_id = patient_id;
        this.service_id = service_id;
        this.appointment_date = appointment_date;
        this.appointment_time = appointment_time;
        this.status = status;
        this.note = note;
    }

    // =============================================================
    // GETTERS VÀ SETTERS
    // =============================================================

    public int getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(int appointment_id) {
        this.appointment_id = appointment_id;
    }

    public String getAppointment_code() {
        return appointment_code;
    }

    public void setAppointment_code(String appointment_code) {
        this.appointment_code = appointment_code;
    }

    public User getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(User patient_id) {
        this.patient_id = patient_id;
    }


    public Action_Service getService_id() {
        return service_id;
    }

    public void setService_id(Action_Service service_id) {
        this.service_id = service_id;
    }

    public LocalDate getAppointment_date() {
        return appointment_date;
    }

    public void setAppointment_date(LocalDate appointment_date) {
        this.appointment_date = appointment_date;
    }

    public LocalTime getAppointment_time() {
        return appointment_time;
    }

    public void setAppointment_time(LocalTime appointment_time) {
        this.appointment_time = appointment_time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "Appointments{" +
                "appointment_id=" + appointment_id +
                ", code='" + appointment_code + '\'' +
                ", patient_id=" + (patient_id != null ? patient_id.getUser_id() : "null") +
                ", service_id=" + (service_id != null ? service_id.getService_id() : "null") +
                ", date=" + appointment_date +
                ", time=" + appointment_time +
                ", status='" + status + '\'' +
                '}';
    }
}