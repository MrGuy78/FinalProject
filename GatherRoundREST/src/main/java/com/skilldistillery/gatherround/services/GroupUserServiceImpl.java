package com.skilldistillery.gatherround.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.repositories.GroupUserRepository;

@Service
public class GroupUserServiceImpl implements GroupUserService {

	@Autowired
	private GroupUserRepository groupUserRepository;

	@Override
	public GroupUser findByUsernameAndGroupId(String username, int groupId) {
		return groupUserRepository.findByUserUsernameAndSocialGroup_Id(username, groupId);
	}

	@Override
	public List<GroupUser> findBySocialGroupId(int groupId) {
		
		return groupUserRepository.findBySocialGroup_Id(groupId);
	}
	
	


	
}
