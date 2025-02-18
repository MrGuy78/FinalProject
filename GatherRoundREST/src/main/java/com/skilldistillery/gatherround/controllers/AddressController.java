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

import com.skilldistillery.gatherround.entities.Address;
import com.skilldistillery.gatherround.services.AddressService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class AddressController {

	@Autowired
	private AddressService addressService;

	@PostMapping("groups/{groupId}/events/{eventId}/address")
	public Address createAddressForEvent(@PathVariable("eventId") int eventId, @PathVariable("groupId") int groupId,
			@RequestBody Address address, Principal principal, HttpServletResponse response,
			HttpServletRequest request) {
		Address newAddress = addressService.createAddressForEvent(principal.getName(), groupId, eventId, address);

		if (newAddress == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return newAddress;
	}

	@GetMapping("groups/{groupId}/addresses")
	public List<Address> findAddressByGroup(@PathVariable("groupId") int groupId, HttpServletResponse response,
			HttpServletRequest request) {
		List<Address> groupAddresses = addressService.addressByGroup(groupId);
		if (groupAddresses == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
		}
		response.setStatus(HttpServletResponse.SC_OK); // 200
		return groupAddresses;
	}

}
