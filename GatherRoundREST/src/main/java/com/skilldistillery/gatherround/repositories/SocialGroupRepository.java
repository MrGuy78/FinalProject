package com.skilldistillery.gatherround.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialGroup;

public interface SocialGroupRepository extends JpaRepository<SocialGroup, Integer> {

	SocialGroup findGroupById(int groupId);
	
	
}
