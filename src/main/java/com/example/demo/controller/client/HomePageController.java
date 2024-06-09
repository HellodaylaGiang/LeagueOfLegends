package com.example.demo.controller.client;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Product;
import com.example.demo.domain.User;
import com.example.demo.domain.dto.RegisterDTO;
import com.example.demo.service.OrderService;
import com.example.demo.service.ProductService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;

    public HomePageController(ProductService productService,
            UserService userService,
            PasswordEncoder passwordEncoder,
            OrderService orderService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.orderService = orderService;
    }

    @GetMapping("/")
    public String getMethodName(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 8);
        Page<Product> pageP = this.productService.getAllProduct(pageable);

        List<Product> listP = pageP.getContent();

        model.addAttribute("listProduct", listP);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageP.getTotalPages());
        return "/client/homepage/show";
    }

    @GetMapping("/client-show-all-champion")
    public String showAll(Model model) {

        model.addAttribute("listProduct", this.productService.getAllProductNotPagination());
        return "/client/homepage/show";
    }

    @GetMapping("/register")
    public String getMethodName1(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "/client/auth/register";
    }

    @PostMapping("/register")
    public String postMethodName(@Valid @ModelAttribute("registerUser") RegisterDTO registerDTO,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return "/client/auth/register";
        }

        User u = this.userService.registerDTOtoUser(registerDTO);
        String hashPass = this.passwordEncoder.encode(u.getPassword());

        u.setRole(this.userService.getRoleByName("USER"));
        u.setPassword(hashPass);
        this.userService.handleSaveUser(u);

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getMethodName3(Model model) {
        return "/client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getMethodName4(Model model) {
        return "/client/auth/deny";
    }

    @GetMapping("/order-history")
    public String getMethodName5(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");

        User u = userService.findUserById(id);
        model.addAttribute("orders", this.orderService.getOrderByUser(u));
        return "/client/homepage/order-history";
    }
}
