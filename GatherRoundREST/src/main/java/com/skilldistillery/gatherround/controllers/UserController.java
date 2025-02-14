package com.skilldistillery.gatherround.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping(path="users")
	public List<User> showAllUsers () {
		return null;
	}
}
