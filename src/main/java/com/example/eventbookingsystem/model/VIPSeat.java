package com.example.eventbookingsystem.model;

public class VIPSeat extends Seat {


    private boolean includesLounge;

    public VIPSeat(String seatId, String venueId, String rowNumber, int seatNumber, double price, boolean includesLounge) {
        super(seatId, venueId, rowNumber, seatNumber, price);
        this.includesLounge = includesLounge;
    }


    @Override
    public String getSeatType() {

        return "VIP";
    }

    @Override
    public String toFileString() {

        return super.toFileString() + "," + includesLounge;
    }

    // --- Getter and Setter ---

    public boolean isIncludesLounge() {

        return includesLounge;
    }

    public void setIncludesLounge(boolean includesLounge) {

        this.includesLounge = includesLounge;
    }

    @Override
    public String toString() {

        return super.toString() + " | Lounge Access: " + (includesLounge ? "Yes" : "No");
    }
}

