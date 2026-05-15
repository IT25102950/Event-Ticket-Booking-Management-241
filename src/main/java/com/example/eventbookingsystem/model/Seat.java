package com.example.eventbookingsystem.model;

public abstract class Seat {


    private String seatId;
    private String venueId;
    private String rowNumber;
    private int seatNumber;
    private String status;
    private double price;

    public Seat(String seatId, String venueId, String rowNumber, int seatNumber, double price) {
        this.seatId = seatId;
        this.venueId = venueId;
        this.rowNumber = rowNumber;
        this.seatNumber = seatNumber;
        this.price = price;
        this.status = "AVAILABLE";
    }

    public abstract String getSeatType();


    public boolean isAvailable() {
        return "AVAILABLE".equalsIgnoreCase(this.status);
    }


    public String toFileString() {
        return seatId + "," + venueId + "," + rowNumber + "," + seatNumber + ","
                + getSeatType() + "," + status + "," + price;
    }


    public String getSeatId() {

        return seatId;
    }

    public void setSeatId(String seatId) {

        this.seatId = seatId;
    }

    public String getVenueId() {

        return venueId;
    }

    public void setVenueId(String venueId) {
        this.venueId = venueId;
    }

    public String getRowNumber() {

        return rowNumber;
    }

    public void setRowNumber(String rowNumber) {

        this.rowNumber = rowNumber;
    }

    public int getSeatNumber() {

        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {

        this.seatNumber = seatNumber;
    }

    public String getStatus() {

        return status;
    }

    public void setStatus(String status) {

        this.status = status;
    }

    public double getPrice() {

        return price;
    }

    public void setPrice(double price) {

        this.price = price;
    }

    @Override
    public String toString() {
        return "[" + getSeatType() + "] Seat " + rowNumber + seatNumber
                + " | Status: " + status + " | Price: $" + price;
    }
}

