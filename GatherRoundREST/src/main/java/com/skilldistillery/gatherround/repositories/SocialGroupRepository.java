package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialGroup;

public interface SocialGroupRepository extends JpaRepository<SocialGroup, Integer> {

	SocialGroup findGroupById(int groupId);

	SocialGroup findByIdAndOwner_Username(int groupId, String username);
	
	List<SocialGroup> findByOwner_Username(String username);
	
	List<SocialGroup> findByUser_IdAndUser_Username(String username);
		
}
