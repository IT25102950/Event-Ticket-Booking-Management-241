package com.example.eventbookingsystem.controller;

import com.example.eventbookingsystem.service.DashboardService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;

    @Controller
    public class AdminController {
        private final DashboardService dashboardService = new DashboardService();

        @GetMapping("/admin/dashboard")
        public String viewDashboard(Model model) {

            // Send data to the frontend
            model.addAttribute("totalBookings", dashboardService.countTotalBookings());
            model.addAttribute("totalRevenue", dashboardService.calculateTotalRevenue());
            return "admin-dashboard";
        }
    }

