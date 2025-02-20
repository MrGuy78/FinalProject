package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.SocialEvent;

public interface SocialEventRepository extends JpaRepository<SocialEvent, Integer> {
	
	List<SocialEvent> findBySocialGroup_Id(int groupId);
	
	List<SocialEvent> findBySocialGroup_IdAndSocialGroup_GroupUsers_User_UsernameAndSocialGroup_GroupUsers_ApprovedTrueAndEnabledTrueOrSocialGroup_IdAndMemberOnlyFalseAndEnabledTrue (int groupId, String username, int groupId2);
}
