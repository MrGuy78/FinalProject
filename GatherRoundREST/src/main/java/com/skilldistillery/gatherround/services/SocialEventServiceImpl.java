package com.skilldistillery.gatherround.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.AddressRepository;
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
	
	@Autowired
	private AddressRepository addressRepo;

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
		if(event.getMeetAddress() != null) {
			addressRepo.saveAndFlush(event.getMeetAddress());
		}
		return eventRepository.saveAndFlush(event);
	}

	@Override
	public SocialEvent show(int eventId) {
		return eventRepository.findById(eventId).orElse(null);
	}

	@Override
	public SocialEvent update(String username, int eventId, SocialEvent event, int groupId) {
		User managedUser = userRepository.
				findByUsernameAndSocialGroups_IdOrUsernameAndGroupUsers_SocialGroup_IdAndGroupUsers_LeaderIsTrue(username, groupId, username, groupId);
		if (managedUser == null) {
			return null;
		}
		SocialEvent managedSocialEvent = eventRepository.findById(eventId).orElse(null );
		if (managedSocialEvent != null) {
			managedSocialEvent.setTitle(event.getTitle());
			managedSocialEvent.setDescription(event.getDescription());
			managedSocialEvent.setImageUrl(event.getImageUrl());
			managedSocialEvent.setEventDate(event.getEventDate());
			managedSocialEvent.setStartTime(event.getStartTime());
			managedSocialEvent.setEndTime(event.getEndTime());
			managedSocialEvent.setCost(event.getCost());
			managedSocialEvent.setMemberOnly(event.isMemberOnly());
			managedSocialEvent.setMeetAddress(event.getMeetAddress());
			managedSocialEvent.setEventAddress(event.getEventAddress());
			
			eventRepository.saveAndFlush(managedSocialEvent);

		}
		return managedSocialEvent;
	}
	}
