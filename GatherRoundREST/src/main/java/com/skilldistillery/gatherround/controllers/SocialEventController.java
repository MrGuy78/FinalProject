package com.skilldistillery.gatherround.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.services.SocialEventService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class SocialEventController {
	
	@Autowired
	private SocialEventService eventService;
	

	@GetMapping("events/{group}")
	public List<SocialEvent> index(@PathVariable("group") String groupName, HttpServletRequest req, HttpServletResponse res){
		
		List<SocialEvent> events = eventService.findByGroup(groupName);
		if(events == null) {
			res.setStatus(HttpServletResponse.SC_NOT_FOUND);
		}
		res.setStatus(HttpServletResponse.SC_OK);
		return events;
	}
	

}
