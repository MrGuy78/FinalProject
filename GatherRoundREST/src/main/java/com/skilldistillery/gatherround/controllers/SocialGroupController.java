package com.skilldistillery.gatherround.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.GroupCategory;
import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.services.GroupUserService;
import com.skilldistillery.gatherround.services.SocialGroupService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class SocialGroupController {

	@Autowired
	private SocialGroupService socialGroupService;

	@Autowired
	private GroupUserService groupUserService;
	
	@GetMapping("groups")
	public List<SocialGroup> findAllGroups() {
		return socialGroupService.index();
	}

	@GetMapping("groups/owned")
	public List<SocialGroup> findCurrentUserGroups(Principal principal) {
		return socialGroupService.loggedInUserGroups(principal.getName());
	}

	@GetMapping("groups/{groupId}")
	public SocialGroup findGroupById(@PathVariable("groupId") int groupId) {
		SocialGroup foundGroup = socialGroupService.show(groupId);
		return foundGroup;
	}

	@GetMapping("categories")
	public List<GroupCategory> findAllCategories() {
		return socialGroupService.showAllCategories();
	}
	
	@GetMapping("groups/categories/{categoryId}")
	public List<SocialGroup> findGroupByCategory(@PathVariable("categoryId") int categoryId, HttpServletResponse response ){
		List<SocialGroup> groupsByCategory = socialGroupService.findGroupByCategory(categoryId);
		if(groupsByCategory == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return groupsByCategory;
	
	}

	@PutMapping("groups/{groupId}")
	public SocialGroup editGroup(@PathVariable("groupId") int groupId, 
			@RequestBody SocialGroup socialGroup,
			Principal principal, HttpServletRequest request, 
			HttpServletResponse response) {
		try {
			socialGroup = socialGroupService.update(socialGroup, principal.getName(), groupId);
			response.setStatus(HttpServletResponse.SC_OK); // 200
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return socialGroup;
	}

	@PostMapping({ "groups", "/groups" })
	public SocialGroup addNewGroup(@RequestBody SocialGroup socialGroup, Principal principal,
			HttpServletRequest request, HttpServletResponse response) {
		SocialGroup createdGroup = null;
		try {
			createdGroup = socialGroupService.create(socialGroup, principal.getName());
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
	
	@PostMapping("groups/{groupId}/members")
	public GroupUser addGroupMember(@PathVariable("groupId") int groupId,
			Principal principal, HttpServletRequest request, 
			HttpServletResponse response) {
		GroupUser createdGroupUser = null;
		try {
			createdGroupUser = groupUserService.addGroupMember(principal.getName(), groupId);
			if(createdGroupUser != null) {
				response.setStatus(HttpServletResponse.SC_CREATED); // 201
			} else {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return createdGroupUser;
	}


}
