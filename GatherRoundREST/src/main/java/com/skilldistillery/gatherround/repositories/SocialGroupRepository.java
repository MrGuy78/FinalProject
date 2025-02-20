package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialGroup;

public interface SocialGroupRepository extends JpaRepository<SocialGroup, Integer> {

	SocialGroup findGroupById(int groupId);

	SocialGroup findByIdAndOwner_Username(int groupId, String username);
	
<<<<<<< HEAD
	List<SocialGroup> findByOwner_Username(String username);
=======
	List<SocialGroup> findByCategory_Id(int categoryId);
	
>>>>>>> c7abd5cd8f0b342c6ec6ead095921e35976b4448
	
	List<SocialGroup> findByUser_IdAndUser_Username(String username);
		
}
