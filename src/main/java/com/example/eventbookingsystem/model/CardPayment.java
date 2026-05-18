package com.example.eventbookingsystem.model;

public class CardPayment extends Payment {

    private String cardNumber;
    private String cardHolder;
    private String expiryDate;


    public CardPayment(int bookingId, String customerName, double amount, String cardNumber, String cardHolder, String expiryDate) {

        super(bookingId, customerName, amount, "CARD");
        this.cardNumber = maskCardNumber(cardNumber);
        this.cardHolder = cardHolder;
        this.expiryDate = expiryDate;
    }

    public CardPayment() {
        super();
        setPaymentMethod("CARD");
    }

    @Override
    public String processPayment() {

        if (cardNumber == null || cardNumber.isEmpty()) {
            setStatus("FAILED");
            return "Payment FAILED: Invalid card number.";
        }

        if (cardHolder == null || cardHolder.trim().isEmpty()) {
            setStatus("FAILED");
            return "Payment FAILED: Card holder name is required.";
        }

        if (expiryDate == null || expiryDate.isEmpty()) {
            setStatus("FAILED");
            return "Payment FAILED: Expiry date is required.";
        }

        setStatus("COMPLETED");
        return "Card payment of Rs." + String.format("%.2f", getAmount()) + " processed successfully. Card ending in " + cardNumber;
    }

    private String maskCardNumber(String rawNumber) {
        if (rawNumber == null) return null;
        String cleaned = rawNumber.replaceAll("\\s+", "");
        if (cleaned.length() < 4) return cleaned;
        return cleaned.substring(cleaned.length() - 4);
    }

    public String getCardNumber() {
        return cardNumber;
    }
    public String getCardHolder() {
        return cardHolder;
    }
    public String getExpiryDate() {
        return expiryDate;
    }

    public void setCardNumber(String cardNumber){
        this.cardNumber = maskCardNumber(cardNumber);
    }
    public void setCardHolder(String cardHolder) {
        this.cardHolder = cardHolder;
    }
    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
}