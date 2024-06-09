package com.example.demo.service.validator;

import org.springframework.stereotype.Service;

import com.example.demo.domain.dto.RegisterDTO;
import com.example.demo.service.UserService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match

        if (user.getFirstName().isBlank()) {
            context.buildConstraintViolationWithTemplate("First name không được trống")
                    .addPropertyNode("firstName") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getLastName().isBlank()) {
            context.buildConstraintViolationWithTemplate("Last name không được trống")
                    .addPropertyNode("lastName") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getPassword().isBlank()) {
            context.buildConstraintViolationWithTemplate("Passwords không được trống")
                    .addPropertyNode("password") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getEmail().isBlank()) {
            context.buildConstraintViolationWithTemplate("Email không được trống")
                    .addPropertyNode("email") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        String regex = "^(?=.*[A-Z]).*$";
        if (!user.getPassword().matches(regex)) {
            context.buildConstraintViolationWithTemplate("Pass phải có 1 kí tự in hoa")
                    .addPropertyNode("password")// trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Confirm Passwords chưa trùng với password")
                    .addPropertyNode("confirmPassword") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // Additional validations can be added here
        // check email
        if (this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")// trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getAddress().isBlank()) {
            context.buildConstraintViolationWithTemplate("Address không được trống")
                    .addPropertyNode("address") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (user.getPhone().isBlank()) {
            context.buildConstraintViolationWithTemplate("Phone không được trống")
                    .addPropertyNode("phone") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (!user.getPhone().matches("^\\d+")) {
            context.buildConstraintViolationWithTemplate("Phone phải là số")
                    .addPropertyNode("phone") // trường thông tin báo lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        return valid;
    }
}
