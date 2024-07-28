package com.example.demo.domain.dto;

import com.example.demo.service.validator.RegisterChecked;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

@RegisterChecked
public class RegisterDTO {
    @Size(min = 3, message = "Firstname tối thiểu 3 kí tự")
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String confirmPassword;
    private String address;
    private String phone;
}
