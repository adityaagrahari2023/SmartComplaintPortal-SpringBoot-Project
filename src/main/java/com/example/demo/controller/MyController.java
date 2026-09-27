package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.RegisterRequest;
import com.example.demo.entities.User;
import com.example.demo.service.UserService;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class MyController {

    @Autowired
    private UserService userService;

    // ================= HOME =================
    @GetMapping(path= {"index","home"})
    public String home() {
        return "index";
    }

    // ================= REGISTRATION =================
    @GetMapping("/registration")
    public String registrationPage() {
        return "registration";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute RegisterRequest request, Model model) {
        userService.registerUser(request);
        model.addAttribute("message", "Registration successful!");
        return "registration";
    }

    // ================= LOGIN =================
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                         @RequestParam String password,
                         HttpSession session,
                         Model model) {

        User user = userService.login(email, password);

        if (user == null) {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }

        session.setAttribute("loggedInUser", user);

        String role = user.getRole();

        if (role.equalsIgnoreCase("ADMIN")) {
            return "redirect:/admin/dashboard";
        } else if (role.equalsIgnoreCase("AGENT")) {
            return "redirect:/agent/dashboard";
        } else {
            return "redirect:/customer/dashboard";
        }
    }

    // ================= LOGOUT =================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // ================= DASHBOARDS =================
    @GetMapping("/customer/dashboard")
    public String customerDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "customer/dashboard";
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "admin/dashboard";
    }

    @GetMapping("/agent/dashboard")
    public String agentDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "agent/dashboard";
    }

    // ================= CUSTOMER SUB-PAGES =================
    @GetMapping("/customer/raise-complaint")
    public String raiseComplaint() {
        return "customer/raise-complaint";
    }

    @GetMapping("/customer/my-complaints")
    public String myComplaints() {
        return "customer/my-complaints";
    }

    @GetMapping("/customer/track-complaint")
    public String trackComplaint() {
        return "customer/track-complaint";
    }

    // ================= PROFILE =================
    @GetMapping("/customer/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "customer/profile";
    }

    @PostMapping("/customer/profile/upload-photo")
    public String uploadPhoto(@RequestParam("photo") MultipartFile photo,
                               HttpSession session) throws Exception {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        if (!photo.isEmpty()) {
            String uploadDir = System.getProperty("user.dir") + "/uploads/";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String fileName = "user_" + user.getId() + "_" + photo.getOriginalFilename();
            Path filePath = Paths.get(uploadDir + fileName);
            Files.write(filePath, photo.getBytes());

            user.setPhotoUrl("/uploads/" + fileName);
            userService.updateUser(user);

            session.setAttribute("loggedInUser", user);
        }

        return "redirect:/customer/profile";
    }
}