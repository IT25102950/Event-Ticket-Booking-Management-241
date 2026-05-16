package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.dao.BookingDAO;
import com.example.eventbookingsystem.model.Booking;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ViewBookingServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @GetMapping("/viewBookings")
    public String viewBookings(
            @RequestParam(required = false) String userId,
            Model model) {

        List<Booking> bookings;
        if (userId != null && !userId.isEmpty()) {
            bookings = bookingDAO.getBookingsByUserId(userId);
            model.addAttribute("searchedUserId", userId);
        } else {
            bookings = bookingDAO.getAllBookings();
        }

        model.addAttribute("bookings", bookings);
        return "myBookings";
    }
}