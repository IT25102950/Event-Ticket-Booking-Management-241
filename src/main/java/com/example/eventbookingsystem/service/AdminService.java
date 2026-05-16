package com.example.eventbookingsystem.service;

import com.example.eventbookingsystem.model.Admin;
import com.example.eventbookingsystem.repository.AdminRepository;
import com.example.eventbookingsystem.util.FileHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    // CREATE - Add a new admin
    public Admin addAdmin(Admin admin) {
        // Save to MySQL database
        Admin saved = adminRepository.save(admin);

        // Also write to admins.txt (File Handling)
        FileHandler.writeAdmin(
                admin.getUsername(),
                admin.getEmail(),
                admin.getFullName(),
                admin.getRole()
        );

        // Write to activity log
        FileHandler.writeLog("Added new admin: " + admin.getUsername(), "System");

        return saved;
    }

    // READ - Get all admins
    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }

    // READ - Get one admin by ID
    public Optional<Admin> getAdminById(int id) {
        return adminRepository.findById(id);
    }

    // READ - Login check
    public Admin login(String username, String password) {
        Optional<Admin> admin = adminRepository.findByUsername(username);
        if (admin.isPresent() && admin.get().getPassword().equals(password)) {

            // Write login activity to log file
            FileHandler.writeLog("Logged in", username);

            return admin.get();
        }
        return null;
    }

    // UPDATE - Edit admin details
    public Admin updateAdmin(Admin admin) {
        // Write to activity log
        FileHandler.writeLog("Updated admin: " + admin.getUsername(), "System");

        return adminRepository.save(admin);
    }

    // DELETE - Remove an admin
    public void deleteAdmin(int id) {
        // Write to activity log before deleting
        adminRepository.findById(id).ifPresent(a ->
                FileHandler.writeLog("Deleted admin: " + a.getUsername(), "System")
        );

        adminRepository.deleteById(id);
    }
}