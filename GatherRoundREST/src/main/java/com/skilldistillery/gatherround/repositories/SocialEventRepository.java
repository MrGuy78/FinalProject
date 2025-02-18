package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialEvent;

public interface SocialEventRepository extends JpaRepository<SocialEvent, Integer> {
	
	List<SocialEvent> findByGroup_Id(int groupId);
	
	
}
