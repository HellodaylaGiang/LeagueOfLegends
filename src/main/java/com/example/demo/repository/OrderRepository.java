package com.example.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.domain.Order;
import com.example.demo.domain.User;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User u);

    Optional<Order> findByPaymentRef(String paymentRef);
}
