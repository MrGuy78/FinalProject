package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.entities.SocialGroup;

public interface SocialGroupService {

	public List<SocialGroup> index();
	
	public List<GroupCategory> showAllCategories();
	
	public List<SocialGroup> findGroupByCategory(int categoryId);
	
	public SocialGroup show(int groupId);

	public SocialGroup create(SocialGroup socialGroup, String username);
	
	public SocialGroup update(SocialGroup socialGroup, String username, int groupId);
	
	public List<SocialGroup> loggedInOwnerGroups(String username);
	
	public List<SocialGroup> loggedInMemberGroups(String username);

	
}
