package com.example.eventbookingsystem.model;

public abstract class Payment {

    private int    paymentId;
    private int    bookingId;
    private String customerName;
    private double amount;
    private String paymentMethod;
    private String status;
    private String transactionDate;
    private String notes;

    public Payment(int bookingId, String customerName, double amount, String paymentMethod) {
        this.bookingId     = bookingId;
        this.customerName  = customerName;
        this.amount        = amount;
        this.paymentMethod = paymentMethod;
        this.status        = "PENDING";

    }

    public Payment() {}

    public abstract String processPayment();


    public int    getPaymentId(){
        return paymentId;
    }
    public int    getBookingId(){
        return bookingId;
    }
    public String getCustomerName(){
        return customerName;
    }
    public double getAmount(){
        return amount;
    }
    public String getPaymentMethod(){
        return paymentMethod;
    }
    public String getStatus(){
        return status;
    }
    public String getTransactionDate(){
        return transactionDate;
    }
    public String getNotes(){
        return notes;
    }

    public void setPaymentId(int paymentId){
        this.paymentId = paymentId;
    }
    public void setBookingId(int bookingId){
        this.bookingId = bookingId;
    }
    public void setCustomerName(String customerName){
        this.customerName = customerName;
    }
    public void setAmount(double amount){
        this.amount = amount;
    }
    public void setPaymentMethod(String paymentMethod){
        this.paymentMethod = paymentMethod;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public void setTransactionDate(String date){
        this.transactionDate = date;
    }
    public void setNotes(String notes){
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Payment{" + "paymentId=" + paymentId +
                ", bookingId=" + bookingId +
                ", customerName='" + customerName + '\'' +
                ", amount=" + amount + ", method='" + paymentMethod + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
