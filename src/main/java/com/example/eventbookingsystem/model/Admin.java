package com.example.eventbookingsystem.model;

import jakarta.persistence.*;

@Entity
@Table(name = "admins")
public class Admin {

    // Encapsulation (Using Private)
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String username;
    private String password;
    private String email;

    @Column(name = "full_name")
    private String fullName;

    private String role;

    @Column(name = "is_active")
    private boolean isActive;

    // No-arg constructor (required by Spring)
    public Admin() {}

    // Parameterized Constructor
    public Admin(int id, String username, String password, String email, String fullName, String role, boolean isActive) {
        this.id       = id;
        this.username = username;
        this.password = password;
        this.email    = email;
        this.fullName = fullName;
        this.role     = role;
        this.isActive = isActive;
    }

    // Constructor for creating a NEW admin
    public Admin(String username, String password, String email, String fullName, String role) {
        this.username = username;
        this.password = password;
        this.email    = email;
        this.fullName = fullName;
        this.role     = role;
        this.isActive = true;
    }

    // Encapsulation (Using Getters and Setters)
    public int getId()                {
        return id;
    }
    public void setId(int id)         {
        this.id = id;
    }

    public String getUsername()       {
        return username;
    }
    public void setUsername(String u) {
        this.username = u;
    }

    public String getPassword()       {
        return password;
    }
    public void setPassword(String p) {
        this.password = p;
    }

    public String getEmail()          {
        return email;
    }
    public void setEmail(String e)    {
        this.email = e;
    }

    public String getFullName()       {
        return fullName;
    }
    public void setFullName(String n) {
        this.fullName = n;
    }

    public String getRole()           {
        return role;
    }
    public void setRole(String r)     {
        this.role = r;
    }

    public boolean isActive()         {
        return isActive;
    }
    public void setActive(boolean a)  {
        this.isActive = a;
    }

    // Abstraction (method subclasses can override)
    public String getPermissionDescription() {

        return "Basic admin access";
    }

    @Override
    public String toString() {
        return "Admin{id=" + id + ", username='" + username + "', role='" + role + "'}";
    }
}