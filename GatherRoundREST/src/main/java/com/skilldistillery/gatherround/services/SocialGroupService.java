package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.SocialGroup;

public interface SocialGroupService {

	public List<SocialGroup> index();
	
	public List<GroupCategory> showAllCategories();
	
	public SocialGroup show(int groupId);

	public SocialGroup create(SocialGroup socialGroup, String username);
	
	public List<SocialGroup> loggedInUserGroups(String username);
	
}
