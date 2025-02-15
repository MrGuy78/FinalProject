package com.skilldistillery.gatherround.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.services.SocialGroupService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class SocialGroupController {

	@Autowired
	private SocialGroupService groupService;

	@GetMapping("groups") 
	public List<SocialGroup> findAllGroups() {
		return groupService.index();
	}
	
	@GetMapping("groups/{groupId}") 
	public SocialGroup findGroupById(@PathVariable("groupId") int groupId) {
		SocialGroup foundGroup = groupService.show(groupId);
		return foundGroup;
	}
	
	@GetMapping("categories") 
	public List<GroupCategory> findAllCategories() {
		return groupService.showAllCategories();
	}
	
	@PostMapping({ "groups", "/groups" })
	public SocialGroup addNewGroup(@RequestBody SocialGroup socialGroup,
			Principal principal,
			HttpServletRequest request, 
			HttpServletResponse response) {
		SocialGroup createdGroup = null;
		try {
			createdGroup = groupService.create(socialGroup, principal.getName());
			if (createdGroup == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
			} else {
				response.setStatus(HttpServletResponse.SC_CREATED); // 201
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return createdGroup;
	}

}
