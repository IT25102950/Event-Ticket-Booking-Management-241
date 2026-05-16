package com.example.model;

public class StandardBooking extends Booking{

    public StandardBooking(){
        super();
        setBookingType("STANDARD");
    }

    //constructor

    public StandardBooking(String userID, String eventID, String eventName
                    ,String eventType, String seatNumber,String bookingDate, double totalPrice){

        super(userID,eventID,eventName,eventType,seatNumber,bookingDate,totalPrice,"STANDARD");

    }

    @Override
    public String getBookingSummary() {
        return "STANDARD" + super.getBookingSummary() + "Total :" + getTotalPrice();
    }

    public String getCancellationPolicy(){
        return "Full refund is available until 24hrs before the event!" ;
    }
}
