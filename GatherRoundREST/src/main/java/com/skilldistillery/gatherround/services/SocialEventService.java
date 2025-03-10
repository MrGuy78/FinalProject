package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.SocialEvent;

public interface SocialEventService {
	
	public List<SocialEvent> findByGroup(int groupId);
	
	public List<SocialEvent> findVisibleEvents (int groupId, String username);
	
	public SocialEvent create(String username, SocialEvent event, int groupId);
	
	public SocialEvent show(int eventId);

	public SocialEvent update(String username, int eventId, SocialEvent event, int groupId);


}
