package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.dao.BookingDAO;
import com.example.eventbookingsystem.model.Booking;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UpdateBookingServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @GetMapping("/updateBooking")
    public String showEditForm(@RequestParam int bookingId, Model model) {
        Booking booking = bookingDAO.getBookingById(bookingId);
        model.addAttribute("booking", booking);
        return "editBooking";
    }

    @PostMapping("/updateBooking")
    public String updateBooking(
            @RequestParam int bookingId,
            @RequestParam String seatNumber,
            @RequestParam String bookingDate,
            @RequestParam String status,
            @RequestParam int numSeats,
            Model model) {

        Booking booking = bookingDAO.getBookingById(bookingId);
        booking.setSeatNumber(seatNumber);
        booking.setBookingDate(bookingDate);
        booking.setStatus(status);
        booking.setNumSeats(numSeats);

        boolean success = bookingDAO.updateBooking(booking);

        if (success) {
            return "redirect:/viewBookings";
        } else {
            model.addAttribute("error", "Update failed! Please try again.");
            model.addAttribute("booking", booking);
            return "editBooking";
        }
    }
}