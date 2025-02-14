package com.skilldistillery.gatherround.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.GroupRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupRepository groupRepository;

	@Autowired
	UserRepository userRepository;

	@Override
	public SocialGroup show(int groupId) {
		return groupRepository.findGroupById(groupId);
	}

	@Override
	public SocialGroup create(SocialGroup socialGroup, String username) {
		User creatingUser = userRepository.findByUsername(username);
		if (creatingUser != null) {
			socialGroup.setOwner(creatingUser);
			return groupRepository.saveAndFlush(socialGroup);
		}
		return null;
	}

}
