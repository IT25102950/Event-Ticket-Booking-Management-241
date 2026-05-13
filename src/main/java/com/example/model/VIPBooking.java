package com.example.model;

public class VIPBooking extends Booking {

    private double vipCharge = 10.0;

    public VIPBooking() {
        super();
        setBookingType("VIP");

    }

    //constructor
    public VIPBooking(String userId, String eventId, String eventName,
                      String eventType, String seatNumber,
                      String bookingDate, double basePrice) {

        super(userId, eventId, eventName, eventType,
                seatNumber, bookingDate, basePrice + 10.0, "VIP");

        this.vipCharge = 10.0;
    }

    public double getVipCharge() {
        return vipCharge;
    }

    public void setVipCharge(double vipCharge) {
        this.vipCharge = vipCharge;
    }

    @Override
    public String getBookingSummary() {
        return "[VIP] " + super.getBookingSummary() +
                " | Price: $" + getTotalPrice() +
                " (including  $" + vipCharge + " VIP Charge)";
    }

    public String getCancellationPolicy() {
        return "Refund is available up to 50%. VIP charge is will not be refunded!";
    }

}


