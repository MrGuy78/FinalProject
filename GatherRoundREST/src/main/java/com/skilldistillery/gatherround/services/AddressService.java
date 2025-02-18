package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.Address;

public interface AddressService {
	
//	public List<Address> index();
	
	public Address createAddressForUser(String username, Address address);
	
	public Address createAddressForEvent(String username, int groupId, int eventId, Address address);
	

}
