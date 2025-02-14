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
	public User show(String user) {
		return userRepository.findAllUsersByUsername(user);
	}

	@Override
	public User create(String user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User update(String user, int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(int userId) {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
