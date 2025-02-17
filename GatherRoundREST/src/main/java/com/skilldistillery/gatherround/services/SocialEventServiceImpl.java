package com.skilldistillery.gatherround.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.SocialEventRepository;
import com.skilldistillery.gatherround.repositories.SocialGroupRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class SocialEventServiceImpl implements SocialEventService {

	@Autowired
	private SocialEventRepository eventRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private SocialGroupRepository socialGroupRepository;

	public List<SocialEvent> findByGroup(int groupId) {
		return eventRepository.findByGroup_Id(groupId);
	}

	@Override
	public SocialEvent create(String username, SocialEvent event, int groupId) {
		User managedUser = userRepository.findByUsernameAndSocialGroups_IdOrUsernameAndGroupUsers_SocialGroup_IdAndGroupUsers_LeaderIsTrue(username, groupId, username, groupId);
		SocialGroup group = socialGroupRepository.findById(groupId).orElse(null);
		if (managedUser == null || group == null) {
			return null;
		}
		event.setUser(managedUser);
		event.setGroup(group);
		event.setEnabled(true);
		return eventRepository.saveAndFlush(event);
	}

}
