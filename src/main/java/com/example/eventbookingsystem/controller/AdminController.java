package com.example.eventbookingsystem.controller;

import com.example.eventbookingsystem.model.Admin;
import com.example.eventbookingsystem.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // ── LOGIN ──────────────────────────────────────────────────────

    @GetMapping("/login")
    public String showLoginPage() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {
        Admin admin = adminService.login(username, password);
        if (admin != null) {
            session.setAttribute("loggedAdmin", admin);
            return "admin/dashboard";
        }
        model.addAttribute("error", "Wrong username or password!");
        return "admin/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "admin/login";
    }

    // ── DASHBOARD ──────────────────────────────────────────────────

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        // Check if logged in
        if (session.getAttribute("loggedAdmin") == null) {
            return "admin/login";
        }

        Admin loggedAdmin = (Admin) session.getAttribute("loggedAdmin");

        model.addAttribute("admins", adminService.getAllAdmins());
        model.addAttribute("totalAdmins", adminService.getAllAdmins().size());

        // This tells the HTML page if the person is SuperAdmin or not
        // true = SuperAdmin, false = Moderator
        model.addAttribute("isSuperAdmin",
                loggedAdmin.getRole().equals("SUPER_ADMIN"));

        return "admin/dashboard";
    }

    // ── MANAGE ADMINS ──────────────────────────────────────────────

    @GetMapping("/manage")
    public String manageAdmins(Model model, HttpSession session) {
        // Check if logged in
        if (session.getAttribute("loggedAdmin") == null) {
            return "admin/login";
        }

        Admin loggedAdmin = (Admin) session.getAttribute("loggedAdmin");

        // Only SUPER_ADMIN can access this page
        // If Moderator tries to open this page, send them to Access Denied
        if (!loggedAdmin.getRole().equals("SUPER_ADMIN")) {
            return "admin/accessdenied";
        }

        model.addAttribute("admins", adminService.getAllAdmins());
        model.addAttribute("newAdmin", new Admin());
        return "admin/manageAdmins";
    }

    // ── ADD ADMIN ──────────────────────────────────────────────────

    @GetMapping("/register")
    public String showRegisterForm(HttpSession session, Model model) {
        // Only SUPER_ADMIN can add new admins
        if (session.getAttribute("loggedAdmin") == null) {
            return "admin/login";
        }
        Admin loggedAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (!loggedAdmin.getRole().equals("SUPER_ADMIN")) {
            return "admin/accessdenied";
        }
        model.addAttribute("newAdmin", new Admin());
        return "admin/adminRegister";
    }

    @PostMapping("/register")
    public String registerAdmin(@ModelAttribute Admin admin) {
        adminService.addAdmin(admin);
        return "admin/manage";
    }

    // ── EDIT ADMIN ─────────────────────────────────────────────────

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id,
                               HttpSession session, Model model) {
        // Only SUPER_ADMIN can edit admins
        if (session.getAttribute("loggedAdmin") == null) {
                return "admin/login";
        }
        Admin loggedAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (!loggedAdmin.getRole().equals("SUPER_ADMIN")) {
            return "admin/accessdenied";
        }
        adminService.getAdminById(id).ifPresent(a -> model.addAttribute("admin", a));
        return "admin/editAdmin";
    }

    @PostMapping("/edit/{id}")
    public String updateAdmin(@PathVariable int id, @ModelAttribute Admin admin) {
        admin.setId(id);
        adminService.updateAdmin(admin);
        return "admin/manage";
    }

    // ── DELETE ADMIN ───────────────────────────────────────────────

    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable int id, HttpSession session) {
        // Only SUPER_ADMIN can delete admins
        if (session.getAttribute("loggedAdmin") == null) {
            return "admin/login";
        }
        Admin loggedAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (!loggedAdmin.getRole().equals("SUPER_ADMIN")) {
            return "admin/accessdenied";
        }
        adminService.deleteAdmin(id);
        return "admin/manage";
    }

    // ── ACCESS DENIED ──────────────────────────────────────────────

    @GetMapping("/accessdenied")
    public String accessDenied() {
        return "admin/accessdenied";
    }
}