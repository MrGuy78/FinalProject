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


	
}
