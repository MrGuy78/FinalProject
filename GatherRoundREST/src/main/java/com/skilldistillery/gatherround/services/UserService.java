package com.skilldistillery.gatherround.services;

import com.skilldistillery.gatherround.entities.User;

public interface UserService {
	
	public User show(String user);

	public User create(String username);

	public User update(String username, int userId);

	public boolean destroy(int userId);

}
