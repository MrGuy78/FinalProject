package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.entities.GroupUserId;

public interface GroupUserRepository extends JpaRepository<GroupUser, GroupUserId> {
	
	GroupUser findByUserUsernameAndSocialGroup_Id(String username, int groupId);
	
	List<GroupUser> findBySocialGroup_Id (int groupId);
	
	boolean existsByIdAndUsername (String username, int groupId);
	
	
	
}
