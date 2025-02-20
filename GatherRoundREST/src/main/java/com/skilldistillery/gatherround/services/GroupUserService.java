package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.GroupUser;

public interface GroupUserService {
	
	GroupUser findByUsernameAndGroupId(String username, int groupId);

	List<GroupUser> findBySocialGroupId (int groupId);
	
	GroupUser addGroupMember (String username, int groupId);

//	boolean removeGroupMember(String username, int groupId);
	
}

