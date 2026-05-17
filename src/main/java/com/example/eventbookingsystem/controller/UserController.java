package com.example.eventbookingsystem.controller;

import com.example.eventbookingsystem.model.User;
import com.example.eventbookingsystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String password,
            Model model) {

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        boolean isRegistered = userService.registerUser(user);

        if (isRegistered) {
            return "redirect:/login";
        } else {
            model.addAttribute("error",
                    "Email already registered. Try a different email.");
            return "register";
        }
    }

    @GetMapping("/users")
    public String getAllUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "userManagement";
    }

    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam int userId) {
        userService.deleteUser(userId);
        return "redirect:/users";
    }

    // GET /editUser - show edit form pre-filled with current data
    @GetMapping("/editUser")
    public String showEditForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/login";
        }
        return "editProfile";
    }

    // POST /editUser - save updated user details
    @PostMapping("/editUser")
    public String updateUser(
            @RequestParam String name,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/login";
        }

        user.setName(name);
        user.setPassword(password);
        userService.updateUser(user);

        // Update session with new details
        session.setAttribute("loggedUser", user);
        session.setAttribute("userName", name);

        return "redirect:/editUser?msg=updated";
    }
}