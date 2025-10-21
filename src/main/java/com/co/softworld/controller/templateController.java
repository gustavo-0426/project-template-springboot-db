package com.co.softworld.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/${api.version}/template")
public class templateController {

    @GetMapping()
    public String getTemplate() {
        return "Welcome to Template Spring Boot!";
    }
    
}