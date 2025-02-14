package com.skilldistillery.gatherround.services;

import java.util.List;

import com.skilldistillery.gatherround.entities.Address;

public interface AddressService {
	
//	public List<Address> index();
	
	public Address show(int addressId);
	
	public Address create(String username, Address address);
	
	public Address update(String username, int addressId, Address address);
	
	public Address delete(String username, int addressId);

}
