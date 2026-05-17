package com.example.eventbookingsystem.Service;

import com.example.eventbookingsystem.model.Venue;
import com.example.eventbookingsystem.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VenueService {

    public void addVenue(Venue venue) {
        String sql = "INSERT INTO venues VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, venue.getVenueId());
            ps.setString(2, venue.getName());
            ps.setString(3, venue.getLocation());
            ps.setInt(4, venue.getTotalSeats());
            ps.setString(5, venue.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Venue> getAllVenues() {
        List<Venue> list = new ArrayList<>();
        String sql = "SELECT * FROM venues";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Venue(
                        rs.getString("venue_id"),
                        rs.getString("name"),
                        rs.getString("location"),
                        rs.getInt("total_seats"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Venue getVenueById(String venueId) {
        String sql = "SELECT * FROM venues WHERE venue_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, venueId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Venue(
                        rs.getString("venue_id"),
                        rs.getString("name"),
                        rs.getString("location"),
                        rs.getInt("total_seats"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void deleteVenue(String venueId) {
        String sql = "DELETE FROM venues WHERE venue_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, venueId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}