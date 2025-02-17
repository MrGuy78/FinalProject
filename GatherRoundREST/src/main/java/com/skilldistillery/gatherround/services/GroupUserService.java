package com.skilldistillery.gatherround.services;

import com.skilldistillery.gatherround.entities.GroupUser;

public interface GroupUserService {
	
	GroupUser findByUsernameAndGroupId(String username, int groupId);

}
