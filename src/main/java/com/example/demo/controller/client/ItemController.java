package com.example.demo.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Cart;
import com.example.demo.domain.CartDetail;
import com.example.demo.domain.Image;
import com.example.demo.domain.Product;
import com.example.demo.domain.Product_;
import com.example.demo.domain.User;
import com.example.demo.domain.dto.ProductCriteriaDTO;
import com.example.demo.domain.skill.ESkill;
import com.example.demo.domain.skill.Intrinsic;
import com.example.demo.domain.skill.QSkill;
import com.example.demo.domain.skill.RSkill;
import com.example.demo.domain.skill.WSkill;
import com.example.demo.repository.CartDetailRepository;
import com.example.demo.repository.CartRepository;
import com.example.demo.service.ImageService;
import com.example.demo.service.ProductService;
import com.example.demo.service.UserService;
import com.example.demo.service.skillservice.ESkillService;
import com.example.demo.service.skillservice.ISkillService;
import com.example.demo.service.skillservice.QSkillService;
import com.example.demo.service.skillservice.RSkillService;
import com.example.demo.service.skillservice.WSkillService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {

    @Autowired
    private UserService userService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    private final ProductService productService;
    private final ImageService imageService;
    private final ISkillService iSkillService;
    private final QSkillService qSkillService;
    private final WSkillService wSkillService;
    private final ESkillService eSkillService;
    private final RSkillService rSkillService;

    public ItemController(ProductService productService, ImageService imageService,
            ISkillService iSkillService, QSkillService qSkillService, WSkillService wSkillService,
            ESkillService eSkillService, RSkillService rSkillService) {
        this.productService = productService;
        this.imageService = imageService;
        this.iSkillService = iSkillService;
        this.qSkillService = qSkillService;
        this.wSkillService = wSkillService;
        this.eSkillService = eSkillService;
        this.rSkillService = rSkillService;
    }

    @GetMapping("/client/product/{id}")
    public String requestMethodName1(@PathVariable("id") long id, Model model) {
        Product p = this.productService.getProductById(id).get();
        model.addAttribute("p", p);

        long idImg = p.getImage1().getId();
        Image img = this.imageService.getImageById(idImg);
        model.addAttribute("img", img);

        Intrinsic iSkill = this.iSkillService.findISkillById(p.getISkill().getId());
        QSkill qSkill = this.qSkillService.findQSkillById(p.getQSkill().getId());
        WSkill wSkill = this.wSkillService.findWSkillById(p.getWSkill().getId());
        ESkill eSkill = this.eSkillService.findESkillById(p.getESkill().getId());
        RSkill rSkill = this.rSkillService.findRSkillById(p.getRSkill().getId());

        model.addAttribute("i", iSkill);
        model.addAttribute("q", qSkill);
        model.addAttribute("w", wSkill);
        model.addAttribute("e", eSkill);
        model.addAttribute("r", rSkill);

        return "/client/product/detail";
    }

    @PostMapping("/add-product-to-card/{id}")
    public String postMethodName(@PathVariable("id") long id, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, 1, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getMethodName(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User u = this.userService.getUserById(id);

        Cart c = this.cartRepository.findByUser(u);
        List<CartDetail> cd = c == null ? new ArrayList<>() : c.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cartDetail : cd) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("listCartDetail", cd);

        model.addAttribute("cart", c);

        return "/client/cart/show";
    }

    @GetMapping("/checkout")
    public String getMethodName1(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User u = this.userService.getUserById(id);

        Cart c = this.cartRepository.findByUser(u);
        List<CartDetail> cd = c == null ? new ArrayList<>() : c.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cartDetail : cd) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("listCartDetail", cd);

        return "/client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart c) {
        List<CartDetail> cartDetails = c == null ? new ArrayList<>() : c.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckOut(cartDetails);
        return "redirect:/checkout";
    }

    @RequestMapping("/cart/delete/{id}")
    public String requestMethodName(@PathVariable("id") long id, HttpServletRequest request) {

        Optional<CartDetail> cd = this.cartDetailRepository.findById(id);
        if (cd.isPresent()) {

            this.cartDetailRepository.delete(cd.get());

            Cart c = this.cartRepository.findById(cd.get().getCart().getId()).get();

            HttpSession session = request.getSession(false);

            if (c.getSum() > 1) {
                c.setSum(c.getSum() - 1);
                session.setAttribute("sum", c.getSum());
                this.cartRepository.save(c);
            } else {
                session.setAttribute("sum", 0);
                this.cartRepository.delete(c);
            }
        }

        return "redirect:/cart";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {

        User currentUser = new User();
        HttpSession session = request.getSession(false);
        currentUser.setId((long) session.getAttribute("id"));

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String getMethodName() {
        return "/client/cart/order-success";
    }

    @GetMapping("/products")
    public String getMethodName6(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {

        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }

        // Sort
        Pageable pageable = PageRequest.of(page - 1, 6);
        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).descending());
            } else {
                pageable = PageRequest.of(page - 1, 6);
            }
        }

        Page<Product> pageP = this.productService.getAllProductWithSpec(pageable,
                productCriteriaDTO);

        List<Product> listP = pageP.getContent().size() > 0 ? pageP.getContent() : new ArrayList<>();
        // Fix lỗi sort nhưng bấm sang trang kế thì mất
        // Lấy URL
        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page trang kế, thay thế page đã có bằng qs, tránh có 2 page= ?
            qs = qs.replace("page=" + page, "");
        }

        model.addAttribute("products", listP);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageP.getTotalPages());
        model.addAttribute("queryString", qs);
        return "/client/product/filter";
    }
}
