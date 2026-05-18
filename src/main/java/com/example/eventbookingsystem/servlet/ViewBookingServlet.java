package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.dao.BookingDAO;
import com.example.eventbookingsystem.model.Booking;
import com.example.eventbookingsystem.model.User;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ViewBookingServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @GetMapping("/viewBookings")
    public String viewBookings(HttpServletRequest request, Model model) {

        // Get logged in user from session
        User loggedUser = (User) request.getSession().getAttribute("loggedUser");

        // If not logged in redirect to login
        if (loggedUser == null) {
            return "redirect:/login";
        }

        // Get bookings for logged in user only
        String userId = String.valueOf(loggedUser.getId());
        List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);

        model.addAttribute("bookings", bookings);
        model.addAttribute("loggedUser", loggedUser);
        return "myBookings";
    }
}