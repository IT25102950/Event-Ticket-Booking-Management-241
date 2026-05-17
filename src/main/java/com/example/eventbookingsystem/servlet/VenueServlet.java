package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.model.Venue;
import com.example.eventbookingsystem.Service.VenueService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class VenueServlet extends HttpServlet {

    private VenueService venueService;

    @Override
    public void init() {
        venueService = new VenueService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("/WEB-INF/Views/addVenue.jsp").forward(request, response);
                break;

            case "delete":
                String venueId = request.getParameter("venueId");
                venueService.deleteVenue(venueId);
                response.sendRedirect(request.getContextPath() + "/venue?action=list&message=Venue+deleted+successfully");
                break;

            case "list":
            default:
                List<Venue> venues = venueService.getAllVenues();
                request.setAttribute("venues", venues);
                request.getRequestDispatcher("/WEB-INF/Views/addVenue.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add":
                String venueId    = request.getParameter("venueId");
                String name       = request.getParameter("name");
                String location   = request.getParameter("location");
                int totalSeats    = Integer.parseInt(request.getParameter("totalSeats"));
                String description = request.getParameter("description");

                Venue venue = new Venue(venueId, name, location, totalSeats, description);
                venueService.addVenue(venue);
                response.sendRedirect(request.getContextPath() + "/venue?action=list&message=Venue+added+successfully");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/venue?action=list");
                break;
        }
    }
}
