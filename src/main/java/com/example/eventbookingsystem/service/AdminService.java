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

    // create
    public Admin addAdmin(Admin admin) {
        Admin saved = adminRepository.save(admin);

        FileHandler.writeAdmin(
                admin.getUsername(),
                admin.getEmail(),
                admin.getFullName(),
                admin.getRole()
        );


        FileHandler.writeLog("Added new admin: " + admin.getUsername(), "System");

        return saved;
    }

    // read
    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }

    // read
    public Optional<Admin> getAdminById(int id) {
        return adminRepository.findById(id);
    }

    // read
    public Admin login(String username, String password) {
        Optional<Admin> admin = adminRepository.findByUsername(username);
        if (admin.isPresent() && admin.get().getPassword().equals(password)) {


            FileHandler.writeLog("Logged in", username);

            return admin.get();
        }
        return null;
    }

    // update
    public Admin updateAdmin(Admin admin) {

        FileHandler.writeLog("Updated admin: " + admin.getUsername(), "System");

        return adminRepository.save(admin);
    }

    // delete
    public void deleteAdmin(int id) {
        // Write to activity log before deleting
        adminRepository.findById(id).ifPresent(a ->
                FileHandler.writeLog("Deleted admin: " + a.getUsername(), "System")
        );

        adminRepository.deleteById(id);
    }
}