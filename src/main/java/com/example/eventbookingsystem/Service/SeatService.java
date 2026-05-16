package com.example.eventbookingsystem.Service;

import com.example.eventbookingsystem.model.*;
import com.example.eventbookingsystem.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatService {

    public void addSeat(Seat seat) {
        String sql = "INSERT INTO seats (seat_id, venue_id, row_label, " +
                "seat_number, seat_type, status, price, " +
                "includes_lounge, has_companion_seat) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, seat.getSeatId());
            ps.setString(2, seat.getVenueId());
            ps.setString(3, seat.getRowNumber());
            ps.setInt(4, seat.getSeatNumber());
            ps.setString(5, seat.getSeatType());
            ps.setString(6, seat.getStatus());
            ps.setDouble(7, seat.getPrice());

            if (seat instanceof VIPSeat) {
                ps.setBoolean(8, ((VIPSeat) seat).isIncludesLounge());
                ps.setBoolean(9, false);
            } else if (seat instanceof WheelchairSeat) {
                ps.setBoolean(8, false);
                ps.setBoolean(9, ((WheelchairSeat) seat).isHasCompanionSeat());
            } else {
                ps.setBoolean(8, false);
                ps.setBoolean(9, false);
            }
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Seat> getSeatsByVenue(String venueId) {
        List<Seat> list = new ArrayList<>();
        String sql = "SELECT * FROM seats WHERE venue_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, venueId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapSeat(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Seat getSeatById(String seatId) {
        String sql = "SELECT * FROM seats WHERE seat_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, seatId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapSeat(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void updateSeatStatus(String seatId, String newStatus) {
        String sql = "UPDATE seats SET status = ? WHERE seat_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, seatId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteSeat(String seatId) {
        String sql = "DELETE FROM seats WHERE seat_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, seatId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private Seat mapSeat(ResultSet rs) throws SQLException {
        String type   = rs.getString("seat_type");
        String seatId = rs.getString("seat_id");
        String venueId = rs.getString("venue_id");
        String row    = rs.getString("row_label");
        int num       = rs.getInt("seat_number");
        double price  = rs.getDouble("price");
        String status = rs.getString("status");

        Seat seat;
        switch (type.toUpperCase()) {
            case "VIP":
                seat = new VIPSeat(seatId, venueId, row, num, price,
                        rs.getBoolean("includes_lounge"));
                break;
            case "WHEELCHAIR":
                seat = new WheelchairSeat(seatId, venueId, row, num, price,
                        rs.getBoolean("has_companion_seat"));
                break;
            default:
                seat = new RegularSeat(seatId, venueId, row, num, price);
                break;
        }
        seat.setStatus(status);
        return seat;
    }
}