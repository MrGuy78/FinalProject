package com.skilldistillery.gatherround.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.GroupCategory;

public interface GroupCategoryRepository extends JpaRepository <GroupCategory, Integer> {

	
}
