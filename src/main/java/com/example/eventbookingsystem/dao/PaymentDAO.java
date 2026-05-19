package com.example.eventbookingsystem.dao;

import com.example.eventbookingsystem.model.CardPayment;
import com.example.eventbookingsystem.model.CashPayment;
import com.example.eventbookingsystem.model.Payment;
import com.example.eventbookingsystem.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean createPayment(Payment payment) {

        String sql = "INSERT INTO payments " +
                "(booking_id, customer_name, amount, payment_method, " +
                " status, card_number, card_holder, notes) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        // try-with-resources: automatically closes connection when done
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set common fields from Payment base class
            ps.setInt   (1, payment.getBookingId());
            ps.setString(2, payment.getCustomerName());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMethod());
            ps.setString(5, payment.getStatus());

            // Set card-specific fields (only if it's a CardPayment)
            if (payment instanceof CardPayment) {
                CardPayment cp = (CardPayment) payment;  // Cast to CardPayment
                ps.setString(6, cp.getCardNumber());     // Last 4 digits
                ps.setString(7, cp.getCardHolder());     // Card holder name
            } else {
                // CashPayment has no card details → store NULL
                ps.setNull(6, Types.VARCHAR);
                ps.setNull(7, Types.VARCHAR);
            }

            ps.setString(8, payment.getNotes());

            // executeUpdate returns number of rows affected
            return ps.executeUpdate() > 0;  // true means successful insert

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error creating payment: " + e.getMessage());
            return false;
        }
    }

    public List<Payment> getAllPayments() {

        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payments ORDER BY transaction_date DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)) {

            // Loop through every row in the result
            while (rs.next()) {
                Payment p = mapResultSetToPayment(rs);  // Convert row → Payment object
                payments.add(p);
            }

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error fetching all payments: " + e.getMessage());
        }

        return payments;  // Returns empty list if error
    }

    public Payment getPaymentById(int paymentId) {

        String sql = "SELECT * FROM payments WHERE payment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, paymentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToPayment(rs);  // Found → return as object
            }

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error fetching payment by ID: " + e.getMessage());
        }

        return null;  // Not found
    }

    public boolean updatePaymentStatus(int paymentId, String newStatus, String notes) {

        String sql = "UPDATE payments SET status = ?, notes = ? WHERE payment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setString(2, notes);
            ps.setInt   (3, paymentId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error updating payment: " + e.getMessage());
            return false;
        }
    }

    //  DELETE – Remove a payment record from the database

    public boolean deletePayment(int paymentId) {

        String sql = "DELETE FROM payments WHERE payment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, paymentId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error deleting payment: " + e.getMessage());
            return false;
        }
    }

    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {

        String method = rs.getString("payment_method");
        Payment payment;

        if ("CARD".equals(method)) {
            // for Create a CardPayment and fill card specific fields
            CardPayment cp = new CardPayment();
            cp.setCardNumber(rs.getString("card_number"));
            cp.setCardHolder(rs.getString("card_holder"));
            payment = cp;
        } else {
            // Create a CashPayment (no extra fields to set from DB)
            payment = new CashPayment();
        }

        // Set common fields from Payment base class
        payment.setPaymentId     (rs.getInt   ("payment_id"));
        payment.setBookingId     (rs.getInt   ("booking_id"));
        payment.setCustomerName  (rs.getString("customer_name"));
        payment.setAmount        (rs.getDouble("amount"));
        payment.setPaymentMethod (method);
        payment.setStatus        (rs.getString("status"));
        payment.setTransactionDate(rs.getString("transaction_date"));
        payment.setNotes         (rs.getString("notes"));

        return payment;
    }
}