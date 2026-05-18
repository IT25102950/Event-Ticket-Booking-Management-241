package com.example.eventbookingsystem.model;

public class CashPayment extends Payment {

    private double amountReceived;
    private double changeGiven;

    public CashPayment(int bookingId, String customerName,
                       double amount, double amountReceived) {

        // Call parent class constructor (Payment)
        super(bookingId, customerName, amount, "CASH");

        this.amountReceived = amountReceived;
        this.changeGiven    = amountReceived - amount;
    }

    public CashPayment() {
        super();
        setPaymentMethod("CASH");
    }

    @Override
    public String processPayment() {

        if (amountReceived < getAmount()) {
            setStatus("FAILED");
            return "Payment FAILED: Insufficient cash. "
                    + "Required: Rs." + String.format("%.2f", getAmount())
                    + " | Received: Rs." + String.format("%.2f", amountReceived);
        }

        setStatus("COMPLETED");
        this.changeGiven = amountReceived - getAmount(); // for Recalculate change

        return "Cash payment of Rs." + String.format("%.2f", getAmount())
                + " received successfully. "
                + "Change to return: Rs." + String.format("%.2f", changeGiven);
    }

    public double getAmountReceived() {
        return amountReceived;
    }

    public double getChangeGiven()    {
        return changeGiven;
    }

    public void setAmountReceived(double amountReceived) {
        this.amountReceived = amountReceived;
        this.changeGiven = amountReceived - getAmount();
    }

    public void setChangeGiven(double changeGiven) {
        this.changeGiven = changeGiven;
    }
}