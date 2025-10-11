package model;

public class ClinicInfo {
    private int clinic_id;
    private String name;
    private String address;
    private String hostline;
    private String email;
    private String working_hours;
    private String description;
    private String logo;

    public ClinicInfo() {
    }

    public ClinicInfo(int clinic_id, String name, String address, String hostline, String email, String working_hours, String description, String logo) {
        this.clinic_id = clinic_id;
        this.name = name;
        this.address = address;
        this.hostline = hostline;
        this.email = email;
        this.working_hours = working_hours;
        this.description = description;
        this.logo = logo;
    }

    public int getClinic_id() {
        return clinic_id;
    }

    public void setClinic_id(int clinic_id) {
        this.clinic_id = clinic_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getHostline() {
        return hostline;
    }

    public void setHostline(String hostline) {
        this.hostline = hostline;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWorking_hours() {
        return working_hours;
    }

    public void setWorking_hours(String working_hours) {
        this.working_hours = working_hours;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

}
