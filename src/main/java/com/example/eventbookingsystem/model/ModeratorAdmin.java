package com.example.eventbookingsystem.model;


//  Inheritance (ModeratorAdmin  extends Admin)

public class ModeratorAdmin extends Admin {

    public ModeratorAdmin(String username, String password, String email, String fullName) {
        super(username, password, email, fullName, "MODERATOR");
    }

    //  Polymorphism  (same method name, different behaviour)
    public String getPermissionDescription() {

        return "Limited access: can only view reports, cannot delete admins";
    }
}
