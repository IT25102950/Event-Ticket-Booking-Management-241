package com.example.eventbookingsystem.model;

 // Using Inheritance
public class Admin extends User {
    private String adminLevel;

    public Admin(String username, String password, String adminLevel) {
        super(username, password);
        this.adminLevel = adminLevel;
    }
}
