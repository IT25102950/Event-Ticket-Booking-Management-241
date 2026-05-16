package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.dao.BookingDAO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CancelBookingServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @GetMapping("/cancelBooking")
    public String cancelBooking(@RequestParam int bookingId) {
        boolean success = bookingDAO.deleteBooking(bookingId);
        if (success) {
            return "redirect:/viewBookings?deleted=true";
        } else {
            return "redirect:/viewBookings?error=true";
        }
    }
}