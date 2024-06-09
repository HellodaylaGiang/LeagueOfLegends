package com.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.service.UserService;

@Controller
public class DashboardController {

    private final UserService UserService;

    public DashboardController(UserService UserService) {
        this.UserService = UserService;
    }

    @GetMapping("/admin")
    public String getMethodName(Model model) {
        model.addAttribute("countUsers", this.UserService.countUsers());
        model.addAttribute("countProducts", this.UserService.countProducts());
        model.addAttribute("countOrders", this.UserService.countOrders());
        return "/admin/dashboard/show";
    }

}
