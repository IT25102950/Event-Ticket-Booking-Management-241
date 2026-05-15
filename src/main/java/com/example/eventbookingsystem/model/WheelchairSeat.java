package com.example.eventbookingsystem.model;

public class WheelchairSeat extends Seat {


    private boolean hasCompanionSeat;

    public WheelchairSeat(String seatId, String venueId, String rowNumber, int seatNumber, double price, boolean hasCompanionSeat) {
        super(seatId, venueId, rowNumber, seatNumber, price);
        this.hasCompanionSeat = hasCompanionSeat;
    }


    @Override
    public String getSeatType() {

        return "WHEELCHAIR";
    }


    @Override
    public String toFileString() {

        return super.toFileString() + "," + hasCompanionSeat;
    }


    public boolean isHasCompanionSeat() {

        return hasCompanionSeat;
    }

    public void setHasCompanionSeat(boolean hasCompanionSeat) {
        this.hasCompanionSeat = hasCompanionSeat;
    }

    @Override
    public String toString() {
        return super.toString() + " | Companion Seat: " + (hasCompanionSeat ? "Yes" : "No");
    }
}

