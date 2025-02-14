package com.skilldistillery.gatherround.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.gatherround.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findAllUsersByUsername(String user);
	
	
	

}
