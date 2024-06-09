package com.example.demo.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.domain.Product;
import com.example.demo.service.ProductService;
import com.example.demo.service.UploadService;

import jakarta.validation.Valid;

@Controller
public class ProductController {

    private ProductService productService;
    private UploadService uploadService;

    public ProductController(ProductService productService,
            UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getMethodName(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        // Phân trang
        // Tại sao hàm of trả về PageRequest, ko phải Pageable mà vẫn được,
        // PageRequest kế thừa AbstractPageRequest
        // AbstractPageRequest lại kế thừa Pageable, nên convert được
        // Lưu ý import Pageable từ SpringFramework domain

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 5);
        // Bỏ mất trang đầu nên là page - 1, truyền động page,
        // trang thứ page -1 hiển thị 8 record

        // trả về dạng Page<T>
        Page<Product> prs = this.productService.getAllProduct(pageable);

        // convert sang List để hiển thị bên jsp
        List<Product> listP = prs.getContent();

        model.addAttribute("products", listP);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "/admin/product/show";
    }

    @RequestMapping("/admin/product/create1")
    public String getMethodName1(Model model) {
        model.addAttribute("newProduct", new Product());
        return "/admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String getMethodName2(@Valid @ModelAttribute("newProduct") Product p,
            BindingResult bindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {
        String avatar = this.uploadService.handSaveUploadFile(file, "img");
        p.setImage(avatar);
        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        } else {
            this.productService.saveProduct(p);
        }
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/delete/{x}")
    public String requestMethodName(@PathVariable("x") long id, Model model) {

        Product p = this.productService.getProductById(id).get();

        model.addAttribute("product", p);
        model.addAttribute("newProduct", p);
        return "/admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postMethodName12(@ModelAttribute("newProduct") Product p) {
        this.productService.deleteProduct(p.getId());
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/{x}")
    public String requestMethodName1(@PathVariable("x") long id, Model model) {

        Product p = this.productService.getProductById(id).get();

        model.addAttribute("product", p);
        return "/admin/product/detail";
    }

    @RequestMapping("/admin/product/update/{x}")
    public String requestMethodName4(@PathVariable("x") long id,
            Model model) {
        Product p = this.productService.getProductById(id).get();
        model.addAttribute("newProduct", p);
        model.addAttribute("img", p.getImage());
        return "/admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postMethodName7(@Valid @ModelAttribute("newProduct") Product p,
            BindingResult bindingResult,
            @RequestParam("hoidanitFile") MultipartFile file,
            Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("img", p.getImage());
            return "/admin/product/update";
        }

        String avatar = this.uploadService.handSaveUploadFile(file, "img");
        Product currentP = this.productService.getProductById(p.getId()).get();
        currentP.setName(p.getName());
        currentP.setPrice(p.getPrice());
        currentP.setDetailDesc(p.getDetailDesc());
        currentP.setShortDesc(p.getShortDesc());
        currentP.setFactory(p.getFactory());
        currentP.setTarget(p.getTarget());
        currentP.setImage(avatar);
        this.productService.saveProduct(currentP);
        return "redirect:/admin/product";
    }

}
