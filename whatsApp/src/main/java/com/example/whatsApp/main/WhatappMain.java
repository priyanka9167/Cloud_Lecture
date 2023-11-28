package com.example.whatsApp.main;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import com.example.whatsApp.model.Role;
import com.example.whatsApp.repository.RoleRepository;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
@ComponentScan(basePackages = {"com.example.whatsApp"})
public class WhatappMain {
    public static void main(String args[]){
        SpringApplication.run(WhatappMain.class,args);
    }

    @Bean
    public CommandLineRunner demo(RoleRepository roleRepo){
        return (args -> {
            Role role = new Role();
            role.setName("ROLE ADMIN");
            roleRepo.save(role);

        });
    }

}
