package com.example.demo.domain;

import java.util.List;

import com.example.demo.service.validator.StrongPassword;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "role_id")
    Role role;

    @OneToMany(mappedBy = "user")
    List<Order> orders;

    @OneToOne(mappedBy = "user")
    private Cart cart;

    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @Size(min = 2, message = "Password tối thiểu 2 kí tự")
    @StrongPassword
    private String password;

    @NotBlank(message = "Fullname không được để trống")
    @Size(min = 3, message = "FullName tối thiểu 3 kí tự")
    private String fullName;

    @NotBlank(message = "Địa chỉ không được trống")
    private String address;

    @NotBlank(message = "Phone không được để trống")
    @Pattern(regexp = "\\d+", message = "Phải nhập vào số.")
    private String phone;

    private String avatar;
}
