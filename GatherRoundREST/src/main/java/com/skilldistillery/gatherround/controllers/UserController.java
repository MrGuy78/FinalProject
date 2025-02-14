package com.skilldistillery.gatherround.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.services.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping("users/{userId}")
	public User findUserById(@PathVariable("userId") int userId) {
		User foundUser = userService.show(userId);
		return foundUser;
	}
	
	@PostMapping({ "users", "/users" })
	public User addNewUser(@RequestBody User user, HttpServletRequest request, 
			HttpServletResponse response) {
		User createdUser = null;
		try {
			createdUser = userService.create(user);
			if (createdUser == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
			} else {
				response.setStatus(HttpServletResponse.SC_CREATED); // 201
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return createdUser;
	}
}
