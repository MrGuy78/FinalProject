package com.skilldistillery.gatherround.services;

import com.skilldistillery.gatherround.entities.User;

public interface AuthService {
	
	public User register(User user);
	
	public User getUserByUsername(String username);

}
