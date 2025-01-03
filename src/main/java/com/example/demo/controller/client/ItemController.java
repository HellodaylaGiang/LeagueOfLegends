package com.example.demo.controller.client;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

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
import com.example.demo.service.VNPayService;
import com.example.demo.service.skillservice.ESkillService;
import com.example.demo.service.skillservice.ISkillService;
import com.example.demo.service.skillservice.QSkillService;
import com.example.demo.service.skillservice.RSkillService;
import com.example.demo.service.skillservice.WSkillService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
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
    private final VNPayService vNPayService;

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
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("paymentMethod") String paymentMethod,
            @RequestParam("totalPrice") String totalPrice) throws NumberFormatException, UnsupportedEncodingException {

        User currentUser = new User();
        HttpSession session = request.getSession(false);
        currentUser.setId((long) session.getAttribute("id"));

        final String uuid = UUID.randomUUID().toString().replace("-", "");

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone,
                paymentMethod, uuid);
        if (!paymentMethod.equals("COD")) {
            String ip = this.vNPayService.getIpAddress(request);
            String vnpUrl = this.vNPayService.generateVNPayURL(Double.parseDouble(totalPrice), uuid, ip);

            return "redirect:" + vnpUrl;
        }
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String getMethodName(
            @RequestParam("vnp_ResponseCode") Optional<String> vnpayResponseCode,
            @RequestParam("vnp_TxnRef") Optional<String> paymentRef) {

        if (vnpayResponseCode.isPresent() && paymentRef.isPresent()) {
            String paymentStatus = vnpayResponseCode.get().equals("00") ? "PAYMENT_SUCCEED" : "PAYMENT_FAILED";
            this.productService.updatePaymentStatus(paymentRef.get(), paymentStatus);
        }
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

    public static String hmacSHA512(final String key, final String data) {
        try {

            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKey);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();

        } catch (Exception ex) {
            return "";
        }
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

}
