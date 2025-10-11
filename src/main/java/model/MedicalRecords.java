package model;

import java.time.LocalDateTime;
// Cần import thêm hai thư viện này cho việc chuyển đổi
import java.sql.Timestamp;
import java.util.Date;

public class MedicalRecords {
    private int record_id;
    private User patient_id;
    private Appointments appointment_id;
    private String diagnosis;
    private String treatment;
    private String notes;
    private LocalDateTime created_at;

    public MedicalRecords() {
    }

    public MedicalRecords(int record_id, User patient_id, Appointments appointment_id, String diagnosis, String treatment, String notes, LocalDateTime created_at) {
        this.record_id = record_id;
        this.patient_id = patient_id;
        this.appointment_id = appointment_id;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.notes = notes;
        this.created_at = created_at;
    }

    public int getRecord_id() {
        return record_id;
    }

    public void setRecord_id(int record_id) {
        this.record_id = record_id;
    }
    public User getPatient_id() {
        return patient_id;
    }
    public void setPatient_id(User patient_id) {
        this.patient_id = patient_id;
    }

    public Appointments getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(Appointments appointment_id) {
        this.appointment_id = appointment_id;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }


    public Timestamp getCreatedAtTimestamp() {
        if (this.created_at == null) {
            return null;
        }
        // Sử dụng Timestamp.valueOf để chuyển đổi từ LocalDateTime sang Timestamp
        return Timestamp.valueOf(this.created_at);
    }
}