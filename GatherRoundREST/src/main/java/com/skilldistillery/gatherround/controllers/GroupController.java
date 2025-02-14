package com.skilldistillery.gatherround.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.SocialGroup;
import com.skilldistillery.gatherround.services.GroupService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class GroupController {

	@Autowired
	private GroupService groupService;

	@GetMapping("groups/{groupId}") 
	public SocialGroup findGroupById(@PathVariable("groupId") int groupId) {
		SocialGroup foundGroup = groupService.show(groupId);
		return foundGroup;
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
