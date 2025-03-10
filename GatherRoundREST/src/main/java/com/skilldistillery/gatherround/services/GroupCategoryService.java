package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.SocialGroup;

public interface GroupCategoryService {
	
	public List<SocialGroup> index();
	
	public GroupCategory show(int categoryId);
	

}
