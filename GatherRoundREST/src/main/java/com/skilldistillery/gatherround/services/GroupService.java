package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.SocialGroup;

public interface GroupService {

	public List<SocialGroup> index();
	
	public SocialGroup show(int groupId);

	public SocialGroup create(SocialGroup socialGroup, String username);
	
}
