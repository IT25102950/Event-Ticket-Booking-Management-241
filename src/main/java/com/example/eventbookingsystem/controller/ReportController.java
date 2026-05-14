package com.example.eventbookingsystem.controller;



import com.example.eventbookingsystem.model.Report;
import com.example.eventbookingsystem.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;

@Controller
@RequestMapping("/reports")
public class ReportController {

    @Autowired
    private ReportService reportService;

    // READ - Show all reports
    @GetMapping
    public String showReports(Model model, HttpSession session) {
        if (session.getAttribute("loggedAdmin") == null) {
            return "admin/login";
        }
        model.addAttribute("reports", reportService.getAllReports());
        return "admin/reportsPanel"; // loads reportsPanel.html
    }

    // CREATE - Generate a new report
    @PostMapping("/generate")
    public String generateReport(@RequestParam String reportTitle,
                                 @RequestParam String reportType,
                                 @RequestParam int totalBookings,
                                 @RequestParam double totalRevenue,
                                 HttpSession session) {
        // Get the logged in admin's ID
        com.example.eventbookingsystem.model.Admin loggedAdmin =
                (com.example.eventbookingsystem.model.Admin) session.getAttribute("loggedAdmin");

        Report report = new Report(
                reportTitle,
                reportType,
                loggedAdmin.getId(),
                totalBookings,
                totalRevenue,
                LocalDate.now() // today's date
        );
        reportService.createReport(report);
        return "redirect:/reports";
    }

    // DELETE - Remove a report
    @GetMapping("/delete/{id}")
    public String deleteReport(@PathVariable int id) {
        reportService.deleteReport(id);
        return "redirect:/reports";
    }
}
