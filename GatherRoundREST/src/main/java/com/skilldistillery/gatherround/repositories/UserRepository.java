package com.skilldistillery.gatherround.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.gatherround.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findByUsername(String user);
	
	User findByUsernameAndSocialGroups_IdOrUsernameAndGroupUsers_SocialGroup_IdAndGroupUsers_LeaderIsTrue(String username, int groupId, String username2, int groupId2);

}
