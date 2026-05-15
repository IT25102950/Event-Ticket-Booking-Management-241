package com.example.eventbookingsystem.dao;

import com.example.eventbookingsystem.model.Booking;
import com.example.eventbookingsystem.model.StandardBooking;
import com.example.eventbookingsystem.model.VIPBooking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/ticket_booking_db";
        String username = "root";
        String password = "2122";
        return DriverManager.getConnection(url, username, password);
    }

    // CREATE - Add new booking
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, event_id, event_name, event_type, seat_number, booking_date, status, total_price, booking_type, num_seats) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getUserId());
            ps.setString(2, booking.getEventId());
            ps.setString(3, booking.getEventName());
            ps.setString(4, booking.getEventType());
            ps.setString(5, booking.getSeatNumber());
            ps.setString(6, booking.getBookingDate());
            ps.setString(7, booking.getStatus());
            ps.setDouble(8, booking.getTotalPrice());
            ps.setString(9, booking.getBookingType());
            ps.setInt(10,booking.getNumSeats());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ - Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // READ - Get booking by ID
    public Booking getBookingById(int id) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBooking(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // READ - Get bookings by user ID
    public List<Booking> getBookingsByUserId(String userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    //update booking
    public boolean updateBooking(Booking booking) {
        String sql = "UPDATE bookings SET seat_number=?, booking_date=?, status=? , num_seats=? WHERE booking_id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getSeatNumber());
            ps.setString(2, booking.getBookingDate());
            ps.setString(3, booking.getStatus());
            ps.setInt(4, booking.getNumSeats());
            ps.setInt(4, booking.getBookingId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //cancel booking
    public boolean deleteBooking(int id) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map ResultSet to Booking object
    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking;
        String type = rs.getString("booking_type");
        if ("VIP".equals(type)) {
            booking = new VIPBooking();
        } else {
            booking = new StandardBooking();
        }
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getString("user_id"));
        booking.setEventId(rs.getString("event_id"));
        booking.setEventName(rs.getString("event_name"));
        booking.setEventType(rs.getString("event_type"));
        booking.setSeatNumber(rs.getString("seat_number"));
        booking.setBookingDate(rs.getString("booking_date"));
        booking.setStatus(rs.getString("status"));
        booking.setTotalPrice(rs.getDouble("total_price"));
        booking.setBookingType(rs.getString("booking_type"));
        booking.setNumSeats(rs.getInt("num_seats"));
        return booking;
    }
}
