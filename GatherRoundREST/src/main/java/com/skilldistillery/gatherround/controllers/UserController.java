package com.skilldistillery.gatherround.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	public User addNewUser(@RequestBody User user, HttpServletResponse response, HttpServletRequest request) {
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

	@PutMapping("users/{userId}")
	public User updatingUser(@PathVariable("userId") int userId, HttpServletResponse response,
			HttpServletRequest request, @RequestBody User user) {
		try {
			user = userService.update(user, userId);
			response.setStatus(HttpServletResponse.SC_OK); // 200
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return user;
	}

	@DeleteMapping("users/{userId}")
	public User disableUser(@PathVariable("userId") int userId, HttpServletResponse response, HttpServletRequest requ) {
		User managedUser = null;
		try {
			managedUser = userService.disableUser(userId);
			if (managedUser == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
			} else {
				response.setStatus(HttpServletResponse.SC_OK); // 200
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return managedUser;
	}

}
