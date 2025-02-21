package com.skilldistillery.gatherround.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.GroupCategoryRepository;
import com.skilldistillery.gatherround.repositories.SocialGroupRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class SocialGroupServiceImpl implements SocialGroupService {

	@Autowired
	SocialGroupRepository groupRepository;

	@Autowired
	GroupCategoryRepository groupCategoryRepository;

	@Autowired
	UserRepository userRepository;

	@Override
	public List<SocialGroup> index() {
		return groupRepository.findAll();
	}

	@Override
	public SocialGroup show(int groupId) {
		return groupRepository.findGroupById(groupId);
	}

	@Override
	public SocialGroup create(SocialGroup socialGroup, String username) {
		User creatingUser = userRepository.findByUsername(username);
		if (creatingUser != null) {
			socialGroup.setOwner(creatingUser);
//			groupUser.setLeader FIX ME
			return groupRepository.saveAndFlush(socialGroup);
		}
		return null;
	}

	@Override
	public List<GroupCategory> showAllCategories() {
		return groupCategoryRepository.findAll();
	}

	@Override
	public List<SocialGroup> loggedInOwnerGroups(String username) {
		return groupRepository.findByOwner_Username(username);
	}
	
	@Override
	public List<SocialGroup> loggedInMemberGroups(String username) {
		return groupRepository.findByGroupUsers_User_UsernameAndGroupUsers_ApprovedTrueAndGroupUsers_LeaderFalseAndEnabledTrue(username);
	}

	@Override
	public SocialGroup update(SocialGroup socialGroup, String username, int groupId) {
		SocialGroup managedSocialGroup = groupRepository.findByIdAndOwner_Username( groupId, username);
		if (managedSocialGroup != null) {
			managedSocialGroup.setName(socialGroup.getName());
			managedSocialGroup.setDescription(socialGroup.getDescription());
			managedSocialGroup.setImageUrl(socialGroup.getImageUrl());
			managedSocialGroup.setCategory(socialGroup.getCategory());
			groupRepository.saveAndFlush(managedSocialGroup);
		}
		return managedSocialGroup;

	}

	@Override
	public List<SocialGroup> findGroupByCategory(int categoryId) {
		return groupRepository.findByCategory_Id(categoryId);
	}
}
