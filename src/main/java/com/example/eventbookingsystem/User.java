package com.example.eventbookingsystem;

public class User {
    private int id;
    private String name;
    private String email;

    public User(int id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }

    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getEmail() {
        return email;
    }


    public String toString() {
        return id + "," + name + "," + email;
    }

    public static User fromString(String data) {
        String[] parts = data.split(",");
        return new User(
                Integer.parseInt(parts[0]),
                parts[1],
                parts[2]
        );
    }
}




