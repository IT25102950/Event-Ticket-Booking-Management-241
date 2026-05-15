package com.example.eventbookingsystem.model;

import java.util.ArrayList;
import java.util.List;

public class Venue {

    private String venueId;
    private String name;
    private String location;
    private int totalSeats;
    private String description;

    private List<Seat> seats;

    public Venue(String venueId, String name, String location, int totalSeats, String description) {
        this.venueId = venueId;
        this.name = name;
        this.location = location;
        this.totalSeats = totalSeats;
        this.description = description;
        this.seats = new ArrayList<>();
    }

    public void addSeat(Seat seat) {
        seats.add(seat);
    }

    public int getAvailableSeatCount() {
        int count = 0;
        for (Seat seat : seats) {
            if (seat.isAvailable()) {
                count++;
            }
        }
        return count;
    }

    public List<Seat> getAvailableSeats() {
        List<Seat> available = new ArrayList<>();
        for (Seat seat : seats) {
            if (seat.isAvailable()) {
                available.add(seat);
            }
        }
        return available;
    }

    public String toFileString() {
        return venueId + "," + name + "," + location + "," + totalSeats + "," + description;
    }

    public static Venue fromFileString(String line) {
        String[] parts = line.split(",");
        return new Venue(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]), parts[4]);

    }

    public String getVenueId() {
        return venueId;
    }

    public void setVenueId(String venueId) {
        this.venueId = venueId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Seat> getSeats() {
        return seats;
    }

    public void setSeats(List<Seat> seats) {
        this.seats = seats;
    }

    @Override
    public String toString() {
        return "Venue ID: " + venueId + " | Name: " + name
                + " | Location: " + location + " | Total Seats: " + totalSeats
                + " | Available: " + getAvailableSeatCount();
    }
}

