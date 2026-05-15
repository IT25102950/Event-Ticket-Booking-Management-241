package com.example.eventbookingsystem.model;

public class SeatFactory {


    public static Seat fromFileString(String line) {
        String[] parts = line.split(",");

        String seatId     = parts[0];
        String venueId    = parts[1];
        String rowNumber  = parts[2];
        int seatNumber    = Integer.parseInt(parts[3]);
        String seatType   = parts[4];
        String status     = parts[5];
        double price      = Double.parseDouble(parts[6]);

        Seat seat;

        switch (seatType.toUpperCase()) {
            case "VIP":
                boolean includesLounge = parts.length > 7 && Boolean.parseBoolean(parts[7]);
                seat = new VIPSeat(seatId, venueId, rowNumber, seatNumber, price, includesLounge);
                break;

            case "WHEELCHAIR":
                boolean hasCompanionSeat = parts.length > 7 && Boolean.parseBoolean(parts[7]);
                seat = new WheelchairSeat(seatId, venueId, rowNumber, seatNumber, price, hasCompanionSeat);
                break;

            case "REGULAR":
            default:
                seat = new RegularSeat(seatId, venueId, rowNumber, seatNumber, price);
                break;
        }

        seat.setStatus(status);
        return seat;
    }
}

