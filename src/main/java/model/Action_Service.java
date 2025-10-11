package model;

import java.time.LocalDateTime;

public class Action_Service {
    private int service_id;
    private String service_name;
    private String category;
    private String description;
    private String target_customer;
    private String process;
    private String technology;
    private String duration;
    private String warranty_policy;
    private double price;
    private boolean is_active;
    private LocalDateTime created_at;

    public Action_Service() {

    }

    public Action_Service(int service_id, String service_name, String category, String description, String target_customer, String process, String technology, String duration, String warranty_policy, double price, boolean is_active, LocalDateTime created_at) {
        this.service_id = service_id;
        this.service_name = service_name;
        this.category = category;
        this.description = description;
        this.target_customer = target_customer;
        this.process = process;
        this.technology = technology;
        this.duration = duration;
        this.warranty_policy = warranty_policy;
        this.price = price;
        this.is_active = is_active;
        this.created_at = created_at;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTarget_customer() {
        return target_customer;
    }

    public void setTarget_customer(String target_customer) {
        this.target_customer = target_customer;
    }

    public String getProcess() {
        return process;
    }

    public void setProcess(String process) {
        this.process = process;
    }

    public String getTechnology() {
        return technology;
    }

    public void setTechnology(String technology) {
        this.technology = technology;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getWarranty_policy() {
        return warranty_policy;
    }

    public void setWarranty_policy(String warranty_policy) {
        this.warranty_policy = warranty_policy;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isIs_active() {
        return is_active;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}
