package com.skilldistillery.gatherround.services;

import com.skilldistillery.gatherround.entities.User;

public interface UserService {
	
	public User show(int userId);

	public User create(User user);

	

}
