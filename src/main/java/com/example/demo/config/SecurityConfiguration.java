package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import com.example.demo.service.CustomUserDetailsService;
import com.example.demo.service.UserService;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    // nạp các thông tin đã customize là passwordEncoder, userDetailsService
    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        // ẩn hiện message user not found mặc định
        // authProvider.setHideUserNotFoundExceptions(false);
        return authProvider;
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return new CustomSuccessHandle();
    }

    // rememberMe() session
    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
        // optionally customize
        rememberMeServices.setAlwaysRemember(true);
        return rememberMeServices;
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // Lưu ý: từ v6.0, Spring auto “validate” forward request, có nghĩa là với
                // spring MVC, các
                // request tới view (jsp) sẽ bị check. lamda
                .authorizeHttpRequests(authorize -> authorize

                        // Cho phép tất cả các yêu cầu có DispatcherType.FORWARD hoặc
                        // DispatcherType.INCLUDE được truy cập mà không cần xác thực.
                        // Trong Spring MVC, khi một request được forward hoặc include từ một servlet
                        // khác(truy cập vào homepage sau đó truy cập đển service để load sp), Spring
                        // Security sẽ tự động "validate" request này
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE)
                        .permitAll()

                        // cho phép được truy cập không xác thực url nào
                        .requestMatchers("/login", "/client/**", "/", "/admin/css/**", "/admin/js/**", "/register",
                                "/products", "/client-show-all-champion")
                        .permitAll()

                        // truy cập admin với account có role ADMIN
                        .requestMatchers("/admin/**").hasRole("ADMIN")

                        // xác thực mọi truy cập
                        .anyRequest().authenticated())

                .sessionManagement((sessionManagement) -> sessionManagement
                        // luôn tạo sesion mới
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                        // hết hạn session logout
                        .invalidSessionUrl("/logout?expired")
                        // giới hạn 1 thời điểm bao nhiêu tk đăng nhập, 1 1tk đăng nhập 1 thiết bị
                        .maximumSessions(1)
                        // fasle người sau vào đá người trước ra
                        // true người sau vào cần đợi người trước dùng hết session
                        .maxSessionsPreventsLogin(false))
                // .csrf(token -> token.disable())
                // vô hiệu hóa, các method Post không cần truyền csrf token vào nữa
                // => code chạy được nhưng giảm độ an toàn

                .logout(logout -> logout.deleteCookies("JSESSIONID").invalidateHttpSession(true))

                // Lưu trữ session khi đóng trình duyệt, mặc định là 30 days
                .rememberMe(r -> r.rememberMeServices(rememberMeServices()))

                // hiển thị form login
                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .failureUrl("/login?error")

                        // xử lý sau khi login account user thì trả về client
                        // account admin trả về trang admin
                        // khi xác thực thành công, Spring Security sẽ gọi đến
                        // customSuccessHandler() để xử lý kết quả.
                        // customSuccessHandler() implements AuthenticationSuccessHandler
                        .successHandler(customSuccessHandler())
                        .permitAll())

                // hiển thị trang deny khi truy cập admin page bằng account user
                .exceptionHandling(ex -> ex.accessDeniedPage("/access-deny"));

        return http.build();
    }

}
