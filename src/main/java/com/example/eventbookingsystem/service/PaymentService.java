package com.example.eventbookingsystem.Service;

import com.example.eventbookingsystem.dao.PaymentDAO;
import com.example.eventbookingsystem.model.CardPayment;
import com.example.eventbookingsystem.model.CashPayment;
import com.example.eventbookingsystem.model.Payment;

import java.util.List;

public class PaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    public String processCardPayment(int bookingId, String customerName,
                                     double amount, String cardNumber,
                                     String cardHolder, String expiry) {

        CardPayment payment = new CardPayment(
                bookingId, customerName, amount, cardNumber, cardHolder, expiry
        );

        String result = payment.processPayment();

        boolean saved = paymentDAO.createPayment(payment);
        if (!saved) {
            return "Error: Payment processed but could not be saved to database.";
        }

        return result;
    }

    public String processCashPayment(int bookingId, String customerName,
                                     double amount, double amountReceived) {

        CashPayment payment = new CashPayment(
                bookingId, customerName, amount, amountReceived
        );

        String result = payment.processPayment();

        boolean saved = paymentDAO.createPayment(payment);
        if (!saved) {
            return "Error: Payment processed but could not be saved to database.";
        }

        return result;
    }

    public List<Payment> getAllTransactions() {
        return paymentDAO.getAllPayments();
    }

    public Payment getPaymentById(int id) {
        return paymentDAO.getPaymentById(id);
    }

    public boolean updateStatus(int paymentId, String newStatus, String notes) {
        return paymentDAO.updatePaymentStatus(paymentId, newStatus, notes);
    }

    public boolean refundAndDelete(int paymentId) {
        paymentDAO.updatePaymentStatus(paymentId, "REFUNDED", "Refund processed by admin");
        return paymentDAO.deletePayment(paymentId);
    }
}