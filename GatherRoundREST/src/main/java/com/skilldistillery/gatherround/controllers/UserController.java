package com.skilldistillery.gatherround.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.services.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping(path="users")
	public User showAllUsers(User user,
			HttpServletResponse response) {
		User foundUsers = userService.show(user.getUsername());
		if (foundUsers == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
		}
		return foundUsers;
	}
}
