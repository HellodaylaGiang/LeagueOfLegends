package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.example.demo.domain.Cart;
import com.example.demo.domain.CartDetail;
import com.example.demo.domain.Order;
import com.example.demo.domain.OrderDetail;
import com.example.demo.domain.Product;
import com.example.demo.domain.User;
import com.example.demo.domain.dto.ProductCriteriaDTO;
import com.example.demo.repository.CartDetailRepository;
import com.example.demo.repository.CartRepository;
import com.example.demo.repository.OrderDetailRepository;
import com.example.demo.repository.OrderRepository;
import com.example.demo.repository.ProductRepository;
import com.example.demo.service.specification.ProductSpec;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // case 1
    public Page<Product> getAllProductWithSpec(Pageable pageable,
            ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getPrice() == null) {
            return this.productRepository.findAll(pageable);
        }

        // khởi tạo combinedSpec để trong lần chạy đầu tiên không bị null
        Specification<Product> combinedSpec = Specification.where(null);
        if (productCriteriaDTO.getTarget() != null &&
                productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpecs = ProductSpec.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        // public static Specification<Product> matchListTarget(List<String> target) {
        // return (root, query, criteriaBuilder) ->
        // criteriaBuilder.in(root.get(Product_.TARGET)).value(target);
        // }

        if (productCriteriaDTO.getFactory() != null &&
                productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpec.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getPrice() != null &&
                productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        return this.productRepository.findAll(combinedSpec, pageable);
    }

    // case 6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        // khởi tạo combinedSpec để trong lần chạy đầu tiên không bị null
        Specification<Product> combinedSpec = Specification.where(null);
        for (String p : price) {
            double min = 0;
            double max = 0;

            switch (p) {
                case "duoi-100-RP":
                    min = 1;
                    max = 99;
                    break;
                case "100-200-RP":
                    min = 100;
                    max = 200;
                    break;
                case "200-300-RP":
                    min = 200;
                    max = 300;
                    break;
                case "tren-300-RP":
                    min = 301;
                    max = 1000;
                    break;
                default:
                    break;
            }
            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpec.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
                // dùng and thì tất cả phải đúng mới chay
                // or để kết hợp các tiêu chí filter
            }
        }

        return combinedSpec;
    }

    // case 2
    // public Page<Product> getAllProductWithSpec(Pageable pageable, double min) {
    // return this.productRepository.findAll(ProductSpec.minPrice(min), pageable);
    // }

    // case 3
    // public Page<Product> getAllProductWithSpec(Pageable pageable, double max) {
    // return this.productRepository.findAll(ProductSpec.maxPrice(max), pageable);
    // }

    // case 4
    // public Page<Product> getAllProductWithSpec(Pageable pageable, List<String>
    // factory) {
    // return this.productRepository.findAll(ProductSpec.matchListFactory(factory),
    // pageable);
    // }

    // case 5
    // public Page<Product> getAllProductWithSpec(Pageable pageable, String price) {

    // if (price.equals("duoi-100-RP")) {
    // double max = 100;
    // return this.productRepository.findAll(ProductSpec.maxPrice(max), pageable);
    // } else if (price.equals("100-200-RP")) {
    // double min = 100;
    // double max = 200;
    // return this.productRepository.findAll(ProductSpec.matchPrice(min, max),
    // pageable);
    // }
    // return this.productRepository.findAll(pageable);
    // }

    public Page<Product> getAllProduct(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

    public List<Product> getAllProductNotPagination() {
        return this.productRepository.findAll();
    }

    public Optional<Product> getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void saveProduct(Product p) {
        this.productRepository.save(p);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    // thêm sản phẩm vào cart, cart detail, update số lượng cart
    public void handleAddProductToCart(String email, long productId, long quantity, HttpSession session) {
        User u = this.userService.getUserByEmail(email);
        // check u có cart chưa, chưa tạo mới
        if (u != null) {
            Cart c = this.cartRepository.findByUser(u);

            if (c == null) {
                Cart otherCart = new Cart();
                otherCart.setUser(u);
                otherCart.setSum(0);

                c = this.cartRepository.save(otherCart);
            }

            Optional<Product> p = this.productRepository.findById(productId);
            if (p.isPresent()) {
                Product realProduct = p.get();

                // check sản phẩm đã thêm vào giỏ hàng chưa

                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(c, realProduct);
                if (oldDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(c);
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);

                    // update cart sum
                    int s = c.getSum() + 1;
                    c.setSum(s);
                    this.cartRepository.save(c);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }
            }
        }
    }

    public void handleUpdateCartBeforeCheckOut(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cd = this.cartDetailRepository.findById(cartDetail.getId());
            if (cd.isPresent()) {
                CartDetail currentCartDetail = cd.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(User u, HttpSession session,
            String receiverName,
            String receiverAddress,
            String receiverPhone) {

        // step 1: get cart by user
        Cart c = this.cartRepository.findByUser(u);
        if (c != null) {
            // get cartDetails by cart
            List<CartDetail> cartDetails = c.getCartDetails();

            if (cartDetails != null) {

                Order o = new Order();
                // User được set id lấy ra bởi session
                o.setUser(u);
                o.setReceiverName(receiverName);
                o.setReceiverAddress(receiverAddress);
                o.setReceiverPhone(receiverPhone);
                o.setStatus("PENDING");

                double sum = 0;

                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice() * cd.getQuantity();
                }

                o.setTotalPrice(sum);
                o = this.orderRepository.save(o);

                for (CartDetail cd : cartDetails) {
                    OrderDetail od = new OrderDetail();
                    od.setOrder(o);
                    od.setProduct(cd.getProduct());
                    od.setPrice((long) cd.getPrice());
                    od.setQuantity(cd.getQuantity());
                    this.orderDetailRepository.save(od);
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(c.getId());

                // step 3: update session
                session.setAttribute("sum", 0);
            }
        }

    }
}
