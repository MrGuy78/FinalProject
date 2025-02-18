package com.skilldistillery.gatherround.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserRepository userRepository;

	@Override
	public User show(int userId) {
		return userRepository.findById(userId).orElse(null);
	}

	@Override
	public User create(User user) {
		return userRepository.saveAndFlush(user);
	}

	@Override
	public User update(User user, int userId) {
		User managedUser = userRepository.findById(userId).orElse(null);
		if (managedUser != null) {
			managedUser.setFirstName(user.getFirstName());
			managedUser.setLastName(user.getLastName());
			managedUser.setEmail(user.getEmail());
			managedUser.setPhone(user.getPhone());
			managedUser.setImageUrl(user.getImageUrl());
			managedUser.setBiography(user.getBiography());
			userRepository.saveAndFlush(managedUser);
		}
		return managedUser;
	}

	@Override
	public User disableUser(int userId) {
		User managedUser = userRepository.findById(userId).orElse(null);
		if (managedUser != null) {
			managedUser.setEnabled(false);
			userRepository.saveAndFlush(managedUser);
		}
		return managedUser;
	}

}
