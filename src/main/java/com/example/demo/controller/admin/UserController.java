package com.example.demo.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.User;
import com.example.demo.service.UploadService;
import com.example.demo.service.UserService;

import jakarta.validation.Valid;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService,
            UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        model.addAttribute("newUser", new User());
        User l = this.userService.getAllUsersByEmail("hoidanitff@gmail.com");
        System.out.println(l);
        return "/admin/user/create";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<User> pageU = this.userService.getAllUsers(pageable);

        List<User> listO = pageU.getContent();

        model.addAttribute("users", listO);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageU.getTotalPages());
        return "/admin/user/show";
    }

    @RequestMapping("/admin/user/{x}")
    public String requestMethodName(@PathVariable long x, Model model) {
        model.addAttribute("user", this.userService.getUserById(x));
        return "/admin/user/detail";
    }

    @RequestMapping("/admin/user/create")
    public String createUserPage1(Model model) {
        model.addAttribute("newUser", new User());
        return "/admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUserPage1(@Valid @ModelAttribute("newUser") User u,
            BindingResult bindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {

        if (bindingResult.hasErrors()) {
            return "/admin/user/create";
        }

        String avatar = this.uploadService.handSaveUploadFile(file, "img");
        String hashPassword = this.passwordEncoder.encode(u.getPassword());

        u.setAvatar(avatar);
        u.setPassword(hashPassword);
        // set object role
        u.setRole(this.userService.getRoleByName(u.getRole().getName()));

        this.userService.handleSaveUser(u);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/delete/{id}")
    public String requestMethodName3(@PathVariable long id, Model model) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "/admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String requestMethodName2(@ModelAttribute("newUser") User u) {
        this.userService.deleteById(u.getId());
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getMethodName(@PathVariable long id,
            Model model) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", this.userService.findUserById(id));
        return "/admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String getMethodName(
            @ModelAttribute("newUser") User u,
            @RequestParam("hoidanitFile") MultipartFile file) {
        User user = this.userService.findUserById(u.getId());
        String avatar = this.uploadService.handSaveUploadFile(file, "img");

        if (user != null) {
            user.setPhone(u.getPhone());
            user.setFullName(u.getFullName());
            user.setAddress(u.getAddress());
            user.setRole(this.userService.getRoleByName(u.getRole().getName()));
            user.setAvatar(avatar);
            this.userService.handleSaveUser(user);
        }
        return "redirect:/admin/user";
    }

}
