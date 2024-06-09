package com.example.demo.service;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

// xử lý login bên SecurityConfiguration 

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    // trả về UserDetails , nhưng đây 1 interface, ko có hàm tạo, ko tạo được class
    // nên dùng 1 lớp con User của security đã implement lại interface này, dùng
    // tính đa hình
    // trả về con sẽ tự động ép kiểu sang cha

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // TODO Auto-generated method stub
        com.example.demo.domain.User u = this.userService.getUserByEmail(username);
        if (u == null) {
            throw new UsernameNotFoundException("user not found");
        }

        // lớp User của security trả về UserDetails, truyền vào 3 tham số là username,
        // password, cllection quyền
        return new User(
                u.getEmail(),
                u.getPassword(),

                // => spring sẽ lưu trong context là ROLE_USER VÀ ROLE_ADMIN,
                // nên thêm prefix ROLE_
                // truyền string ROLE_ vào đối tượng SimpleGrantedAuthority
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + u.getRole().getName())));
    }

}
