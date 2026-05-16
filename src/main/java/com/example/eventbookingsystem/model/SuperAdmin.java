package com.example.eventbookingsystem.model;


//  Inheritance ( SuperAdmin extends Admin)
public class SuperAdmin extends Admin {

    // SuperAdmin constructor
    public SuperAdmin(String username, String password, String email, String fullName) {

        // Call parent class constructor
        super(username, password, email, fullName, "SUPER_ADMIN");
    }

    //  Abstraction (special permission)
    public String getPermissionDescription() {
        return "Full access: can manage all admins, view all reports, delete anything";
    }
}
