package com.skilldistillery.gatherround.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.GroupUser;
import com.skilldistillery.gatherround.services.GroupUserService;

import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class GroupUserController {

	@Autowired
	private GroupUserService groupUserService;

	@GetMapping("groups/{groupId}/groupUsers")
	public GroupUser findByUsernameAndGroupId(@PathVariable("groupId") int groupId, 
			Principal principal, HttpServletResponse response) {
		GroupUser foundGroupUser = groupUserService.findByUsernameAndGroupId(principal.getName(), groupId);
		if(foundGroupUser == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
		}
		return foundGroupUser;
	}
	
	@GetMapping("groups/{groupId}/groupUsers/all")
	public List<GroupUser> findAllGroupUsers(@PathVariable("groupId") int groupId, HttpServletResponse response ){
		return groupUserService.findBySocialGroupId(groupId);
	}
}
