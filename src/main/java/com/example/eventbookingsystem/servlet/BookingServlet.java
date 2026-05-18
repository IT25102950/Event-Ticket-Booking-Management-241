package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.dao.BookingDAO;
import com.example.eventbookingsystem.model.Booking;
import com.example.eventbookingsystem.model.StandardBooking;
import com.example.eventbookingsystem.model.VIPBooking;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.eventbookingsystem.model.User;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BookingServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    // Show booking form
    @GetMapping("/booking")
    public String showBookingForm(
            @RequestParam(required = false) String eventId,
            @RequestParam(required = false) String eventName,
            @RequestParam(required = false) String eventType,
            @RequestParam(required = false) String seatNumber,
            HttpServletRequest request,
            Model model) {

        // Check if user is logged in
        User loggedUser = (User) request.getSession().getAttribute("loggedUser");
        if (loggedUser == null) {
            return "redirect:/login";
        }

        // Auto fill user ID from session
        model.addAttribute("userId", String.valueOf(loggedUser.getId()));
        model.addAttribute("userName", loggedUser.getName());
        model.addAttribute("eventId", eventId);
        model.addAttribute("eventName", eventName);
        model.addAttribute("eventType", eventType);
        model.addAttribute("seatNumber", seatNumber);
        return "bookingForm";
    }

    // Handle booking  submission
    @PostMapping("/booking")
    public String createBooking(
            @RequestParam String userId,
            @RequestParam String eventId,
            @RequestParam String eventName,
            @RequestParam String eventType,
            @RequestParam String seatNumber,
            @RequestParam String bookingDate,
            @RequestParam double totalPrice,
            @RequestParam String bookingType,
            @RequestParam int numSeats,
            Model model) {


        Booking booking;
        if ("VIP".equals(bookingType)) {
            booking = new VIPBooking(userId, eventId, eventName, eventType,
                    seatNumber, bookingDate, totalPrice);
        } else {
            booking = new StandardBooking(userId, eventId, eventName, eventType,
                    seatNumber, bookingDate, totalPrice);
        }
        booking.setNumSeats(numSeats);

        boolean success = bookingDAO.addBooking(booking);

        if (success) {
            return "redirect:/viewBookings";
        } else {
            model.addAttribute("error", "Booking failed! Please try again.");
            return "bookingForm";
        }
    }
}