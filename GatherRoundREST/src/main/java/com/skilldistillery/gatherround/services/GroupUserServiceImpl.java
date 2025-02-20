package com.skilldistillery.gatherround.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.entities.GroupUserId;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;
import com.skilldistillery.gatherround.repositories.GroupUserRepository;
import com.skilldistillery.gatherround.repositories.SocialGroupRepository;
import com.skilldistillery.gatherround.repositories.UserRepository;

@Service
public class GroupUserServiceImpl implements GroupUserService {

	@Autowired
	private GroupUserRepository groupUserRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private SocialGroupRepository socialGroupRepository;

	@Override
	public GroupUser findByUsernameAndGroupId(String username, int groupId) {
		return groupUserRepository.findByUserUsernameAndSocialGroup_Id(username, groupId);
	}

	@Override
	public List<GroupUser> findBySocialGroupId(int groupId) {
		return groupUserRepository.findBySocialGroup_Id(groupId);
	}

	@Override
	public GroupUser addGroupMember(String username, int groupId) {
		User foundUser = userRepository.findByUsername(username);
		SocialGroup foundGroup = socialGroupRepository.findById(groupId).orElse(null);
		GroupUser newMember = null;
		if (foundUser != null && foundGroup != null) {
			newMember = new GroupUser();
			GroupUserId newMemberId = new GroupUserId(foundUser.getId(), groupId);
			newMember.setId(newMemberId);
			newMember.setUser(foundUser);
			newMember.setSocialGroup(foundGroup);
			newMember.setApproved(true);
			newMember.setApprovedDate(LocalDateTime.now());
			newMember.setLeader(false);
			groupUserRepository.saveAndFlush(newMember);
		}
		return newMember;
	}
	
	@Override
	public boolean removeGroupMember(String username, int groupId) {
		boolean wasRemoved = false;
		if (groupUserRepository.existsById(groupId)) {
			groupUserRepository.deleteById(null);
			wasRemoved = true;
		}
		return wasRemoved;
	}

}
