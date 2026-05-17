package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.model.Seat;
import com.example.eventbookingsystem.model.RegularSeat;
import com.example.eventbookingsystem.model.VIPSeat;
import com.example.eventbookingsystem.model.WheelchairSeat;
import com.example.eventbookingsystem.Service.SeatService;
import com.example.eventbookingsystem.Service.VenueService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SeatServlet extends HttpServlet {

    private SeatService seatService;
    private VenueService venueService;

    @Override
    public void init() {
        seatService = new SeatService();
        venueService = new VenueService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {

            case "add":

                request.setAttribute("venues", venueService.getAllVenues());
                request.getRequestDispatcher("/WEB-INF/Views/venueList.jsp").forward(request, response);
                break;

            case "editStatus":
                String seatId = request.getParameter("seatId");
                Seat seat = seatService.getSeatById(seatId);
                request.setAttribute("seat", seat);
                request.getRequestDispatcher("/WEB-INF/Views/venueList.jsp").forward(request, response);
                break;

            case "delete":
                String deleteSeatId = request.getParameter("seatId");
                String venueId = request.getParameter("venueId");
                seatService.deleteSeat(deleteSeatId);
                response.sendRedirect(request.getContextPath() + "/seat?action=view&venueId=" + venueId + "&message=Seat+removed");
                break;

            case "view":
            default:
                String viewVenueId = request.getParameter("venueId");
                List<Seat> seats = seatService.getSeatsByVenue(viewVenueId);
                request.setAttribute("seats", seats);
                request.setAttribute("venueId", viewVenueId);
                request.setAttribute("venue", venueService.getVenueById(viewVenueId));
                request.getRequestDispatcher("/WEB-INF/Views/venueList.jsp").forward(request, response);
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
                String seatId    = request.getParameter("seatId");
                String venueId   = request.getParameter("venueId");
                String row       = request.getParameter("rowNumber");
                int seatNum      = Integer.parseInt(request.getParameter("seatNumber"));
                double price     = Double.parseDouble(request.getParameter("price"));
                String seatType  = request.getParameter("seatType");

                Seat newSeat;
                switch (seatType.toUpperCase()) {
                    case "VIP":
                        boolean lounge = "on".equals(request.getParameter("includesLounge"));
                        newSeat = new VIPSeat(seatId, venueId, row, seatNum, price, lounge);
                        break;
                    case "WHEELCHAIR":
                        boolean companion = "on".equals(request.getParameter("hasCompanionSeat"));
                        newSeat = new WheelchairSeat(seatId, venueId, row, seatNum, price, companion);
                        break;
                    default:
                        newSeat = new RegularSeat(seatId, venueId, row, seatNum, price);
                        break;
                }

                seatService.addSeat(newSeat);
                response.sendRedirect(request.getContextPath() + "/seat?action=view&venueId=" + venueId + "&message=Seat+added");
                break;

            case "updateStatus":
                String updateSeatId = request.getParameter("seatId");
                String newStatus    = request.getParameter("status");
                String redirectVenueId = request.getParameter("venueId");
                seatService.updateSeatStatus(updateSeatId, newStatus);
                response.sendRedirect(request.getContextPath() + "/seat?action=view&venueId=" + redirectVenueId + "&message=Status+updated");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/venue?action=list");
                break;
        }
    }
}
