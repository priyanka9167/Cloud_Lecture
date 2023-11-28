package com.example.whatsApp.controller;
import java.util.Collection;
import java.util.Collections;

import com.example.whatsApp.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.whatsApp.dto.LoginDto;
import com.example.whatsApp.dto.SignUpDto;
import com.example.whatsApp.model.Role;
import com.example.whatsApp.model.User;
import com.example.whatsApp.repository.UserRepository;

@RestController
@RequestMapping("/api")

public class HomeController {


//    @Autowired
//    private AuthenticationConfiguration authConfiguration;
//    @Bean
//    public AuthenticationManager authenticationManager() throws Exception {
//        return authConfiguration.getAuthenticationManager();
//    }
    @Autowired AuthenticationManager authenticationManager;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
//    @Bean
//    public BCryptPasswordEncoder bCryptPasswordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<String> authenticateUser(@RequestBody LoginDto loginDto){
        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(loginDto.getUsername(),
                        loginDto.getPassword()));


    SecurityContextHolder.getContext().setAuthentication(authentication);
    return new ResponseEntity<>("User login sucessfully!...", HttpStatus.OK);

    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@RequestBody SignUpDto signUpDto){
        if(userRepository.existsByUsername(signUpDto.getUsername())){
            return new ResponseEntity<>("Username already exists", HttpStatus.BAD_REQUEST);
        }
//        checking if email exists in the database
        if(userRepository.existsByEmail(signUpDto.getEmail())){
            return  new ResponseEntity<>("Email already exists", HttpStatus.BAD_REQUEST);
        }

        if(userRepository.existsByPhone(signUpDto.getPhone())){
            return  new ResponseEntity<>("Phone already exists", HttpStatus.BAD_REQUEST);
        }

//        creating user object
        User user = new User();
        user.setFirstname(signUpDto.getFirstname());
        user.setLastname(signUpDto.getLastname());
        user.setUsername(signUpDto.getUsername());
        user.setEmail(signUpDto.getEmail());

        user.setPassword(passwordEncoder.encode(signUpDto.getPassword()));

        Role roles = roleRepository.findByName("ROLE ADMIN").get();
        user.setRoles(Collections.singleton(roles));

        userRepository.save(user);

        return new ResponseEntity<>("User is regsitered successfully!", HttpStatus.OK);
    }


}
