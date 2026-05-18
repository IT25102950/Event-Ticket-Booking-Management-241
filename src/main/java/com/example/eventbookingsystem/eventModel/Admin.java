package com.example.eventbookingsystem.eventModel;

public class Admin extends Event {

    private String adminName;

    public Admin() {
    }

    public Admin(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
}
