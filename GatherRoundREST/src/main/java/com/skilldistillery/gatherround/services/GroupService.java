package com.skilldistillery.gatherround.services;

import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.entities.User;

public interface GroupService {

	public SocialGroup show(int groupId);

	public SocialGroup create(SocialGroup socialGroup, String username);
	
}
