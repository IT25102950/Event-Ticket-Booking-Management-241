package com.example.eventbookingsystem.model;

public class Booking {

    private int bookingId;
    private String userId;
    private String eventId;
    private String eventName;
    private String eventType;
    private String seatNumber;
    private String bookingDate;
    private String status;
    private double totalPrice;
    private String bookingType;
    private int numSeats;

    public Booking() {}

    //parameterized constructor
    public Booking(String userId, String eventId, String eventName, String eventType,
                   String seatNumber, String bookingDate,
                   double totalPrice, String bookingType) {

        this.userId = userId;
        this.eventId = eventId;
        this.eventName = eventName;
        this.eventType = eventType;
        this.seatNumber = seatNumber;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
        this.bookingType = bookingType;
        this.status = "CONFIRMED";
    }


    //setters

    public void setBookingId(int bookingId){
        this.bookingId = bookingId;
    }

    public void setUserId(String userId){
        this.userId = userId;
    }


    public void setEventId(String eventId){
        this.eventId = eventId;
    }

    public void setEventName(String eventName){
        this.eventName = eventName;
    }


    public void setEventType(String eventType){
        this.eventType = eventType;
    }


    public void setSeatNumber(String seatNumber){
        this.seatNumber = seatNumber;
    }


    public void setBookingDate(String  bookingDate){
        this.bookingDate = bookingDate;
    }


    public void setStatus(String status){
        this.status = status;
    }


    public void setTotalPrice(double totalPrice){
        this.totalPrice = totalPrice;
    }


    public void setBookingType(String bookingType){
        this.bookingType = bookingType;
    }

    public void setNumSeats(int numSeats){
        this.numSeats = numSeats;
    }



    //getters

    public int getBookingId(){
        return bookingId;
    }

    public String getEventId(){
        return eventId;
    }

    public String getUserId(){
        return userId;
    }
    public String getEventName(){
        return eventName;
    }

    public String getEventType(){
        return eventType;
    }

    public String getSeatNumber(){
        return seatNumber;
    }
    public String getBookingDate(){
        return bookingDate;
    }

    public String getStatus(){
        return status;
    }

    public double getTotalPrice(){
        return totalPrice;
    }

    public String getBookingType(){
        return bookingType;
    }

    public int getNumSeats(){
        return numSeats;
    }



    public String getBookingSummary() {
        return   bookingId +" " +  eventName +" " + seatNumber;
    }




}


