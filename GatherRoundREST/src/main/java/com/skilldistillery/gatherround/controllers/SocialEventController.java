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

import com.skilldistillery.gatherround.entities.SocialEvent;
import com.skilldistillery.gatherround.services.SocialEventService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class SocialEventController {

	@Autowired
	private SocialEventService eventService;

//	@GetMapping("groups/{groupId}/events")
//	public List<SocialEvent> index(@PathVariable("groupId") int groupId, HttpServletResponse response,
//			HttpServletRequest request) {
//		List<SocialEvent> events = eventService.findByGroup(groupId);
//		if (events == null) {
//			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 400
//		}
//		response.setStatus(HttpServletResponse.SC_OK); // 200
//		return events;
//	}
	
	@GetMapping("groups/{groupId}/events")
	public List<SocialEvent> findVisibleEvents(@PathVariable("groupId") int groupId, HttpServletResponse response,
			HttpServletRequest request, Principal principal) {
		List<SocialEvent> events = eventService.findVisibleEvents(groupId, principal.getName());
		if (events == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 400
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return events;
	}

	@PostMapping("groups/{groupId}/events")
	public SocialEvent createEvent(@PathVariable("groupId") int groupId, @RequestBody SocialEvent socialEvent,
			HttpServletResponse response, Principal principal) {
		try {
			socialEvent = eventService.create(principal.getName(), socialEvent, groupId);
			if (socialEvent == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
			socialEvent = null;
		}
		return socialEvent;
	}

	@GetMapping("groups/events/{eventId}")
	public SocialEvent findEventById(@PathVariable("eventId") int eventId, HttpServletResponse response,
			HttpServletRequest request) {
		SocialEvent foundEvent = eventService.show(eventId);
		if (foundEvent == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return foundEvent;
	}

	@PutMapping("groups/{groupId}/events/{eventId}")
	public SocialEvent updateEvent(@PathVariable("eventId") int eventId, @PathVariable("groupId") int groupId,
			@RequestBody SocialEvent socialEvent, Principal principal, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			socialEvent = eventService.update(principal.getName(), eventId, socialEvent, groupId);
			response.setStatus(HttpServletResponse.SC_OK); // 200
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		return socialEvent;
	}
	
	

}
