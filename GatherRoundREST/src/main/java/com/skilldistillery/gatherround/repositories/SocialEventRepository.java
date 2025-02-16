package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialEvent;

public interface SocialEventRepository extends JpaRepository<SocialEvent, Integer> {
	
	//find list of events by group
	List<SocialEvent> findByGroup_Name(String name);
	
}
