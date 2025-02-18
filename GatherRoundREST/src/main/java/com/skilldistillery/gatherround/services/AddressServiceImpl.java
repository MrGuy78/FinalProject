package com.skilldistillery.gatherround.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.Address;
import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.AddressRepository;
import com.skilldistillery.gatherround.repositories.SocialEventRepository;
import com.skilldistillery.gatherround.repositories.SocialGroupRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	private AddressRepository addressRepo;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	private SocialEventRepository eventRepository;
	
	@Autowired
	private SocialGroupRepository socialGroupRepository;

	@Override
	public Address createAddressForUser(String username, Address address) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Address createAddressForEvent(String username, int groupId, int eventId, Address address) {
		User managedUser = userRepository.findByUsernameAndSocialGroups_IdOrUsernameAndGroupUsers_SocialGroup_IdAndGroupUsers_LeaderIsTrue(username, groupId, username, groupId);
		SocialGroup group = socialGroupRepository.findById(groupId).orElse(null);
		SocialEvent event = eventRepository.findById(eventId).orElse(null);
		
		if(managedUser == null || group == null || event == null ) {
			return null;
		}
		addressRepo.saveAndFlush(address);
		event.setMeetAddress(address);
		eventRepository.saveAndFlush(event);
		return address;
	}



	

}
