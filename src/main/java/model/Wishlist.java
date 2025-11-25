package model;

import java.time.LocalDateTime;

public class Wishlist {
    private int wishlist_id;
    private User patient_id;
    private Action_Service service_id;

    private String notes;

    private LocalDateTime add_at;

    public Wishlist() {
    }

    public Wishlist(int wishlist_id, User patient_id, Action_Service service_id, String notes, LocalDateTime add_at) {
        this.wishlist_id = wishlist_id;
        this.patient_id = patient_id;
        this.service_id = service_id;
        this.notes = notes;
        this.add_at = add_at;
    }

    public int getWishlist_id() {
        return wishlist_id;
    }

    public void setWishlist_id(int wishlist_id) {
        this.wishlist_id = wishlist_id;
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

    // Getter/Setter đã sửa lại theo tên biến 'notes'
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getAdd_at() {
        return add_at;
    }

    public void setAdd_at(LocalDateTime add_at) {
        this.add_at = add_at;
    }

    @Override
    public String toString() {
        return "Wishlist{" +
                "wishlist_id=" + wishlist_id +
                ", patient_id=" + patient_id +
                ", service_id=" + service_id +
                ", notes='" + notes + '\'' +
                ", add_at=" + add_at +
                '}';
    }
}