package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User u);

    User findTop1ByEmail(String email);

    User findById(long id);

    boolean existsByEmail(String email);

    User findByEmail(String email);
}
