package com.example.eventbookingsystem.model;

public class RegularSeat extends Seat {

    public RegularSeat(String seatId, String venueId, String rowNumber, int seatNumber, double price) {
        super(seatId, venueId, rowNumber, seatNumber, price);
    }

    @Override
    public String getSeatType() {
        return "REGULAR";
    }
}
