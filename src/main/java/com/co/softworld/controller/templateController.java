package com.co.softworld.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/${api.version}/template")
public class templateController {

    @GetMapping()
    public ResponseEntity<String> getTemplate() {
        return ResponseEntity.ok("Welcome to Template Spring Boot!");
    }
    
}