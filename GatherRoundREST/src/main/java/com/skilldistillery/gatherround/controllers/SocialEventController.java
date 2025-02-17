package com.skilldistillery.gatherround.controllers;

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
	
	@GetMapping("events/{groupId}")
	public List<SocialEvent> index(@PathVariable("groupId") int groupId, 
			HttpServletResponse response,
			HttpServletRequest request){		
		List<SocialEvent> events = eventService.findByGroup(groupId);
		if(events == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 400
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return events;
	}

}
