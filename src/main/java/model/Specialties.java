package model;

import java.io.Serializable;

public class Specialties implements Serializable {
    private int specialtyId;
    private String name;
    private String description;

    public Specialties() {
    }

    public Specialties(int specialtyId, String name, String description) {
        this.specialtyId = specialtyId;
        this.name = name;
        this.description = description;
    }

    // Getter/setter theo convention chuẩn
    public int getSpecialtyId() {
        return specialtyId;
    }

    public void setSpecialtyId(int specialtyId) {
        this.specialtyId = specialtyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Specialties{" +
                "specialtyId=" + specialtyId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}