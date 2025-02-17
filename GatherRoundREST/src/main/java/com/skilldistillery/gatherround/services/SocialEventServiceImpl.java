package com.skilldistillery.gatherround.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.repositories.SocialEventRepository;

@Service
public class SocialEventServiceImpl implements SocialEventService{

	@Autowired
	private SocialEventRepository eventRepo;

	
	public List<SocialEvent> findByGroup(int groupId){
		return eventRepo.findByGroup_Id(groupId);
	}


	
}
