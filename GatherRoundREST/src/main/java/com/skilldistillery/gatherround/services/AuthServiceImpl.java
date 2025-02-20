package com.skilldistillery.gatherround.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.AddressRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private AddressRepository addressRepository;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public User register(User user) {
	    String encodedPassword = encoder.encode(user.getPassword());
	    user.setPassword(encodedPassword); // only persist encoded password
	    user.setEnabled(true);
	    user.setRole("standard");
	    if(user.getAddress() != null) {
	    	addressRepository.saveAndFlush(user.getAddress());
	    }
	    userRepository.saveAndFlush(user);
	    return user;
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepository.findByUsername(username);
	}
}
