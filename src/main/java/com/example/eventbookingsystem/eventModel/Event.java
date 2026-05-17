package com.example.eventbookingsystem.eventModel;

public class Event {

    private int id;
    private String name;
    private String type;
    private String date;
    private String venue;
    private int seats;
    private double price;

    public Event() {
    }

    public Event(int id, String name, String type, String date, String venue, int seats, double price) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.date = date;
        this.venue = venue;
        this.seats = seats;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
