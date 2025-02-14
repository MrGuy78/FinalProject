package com.skilldistillery.gatherround.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.gatherround.entities.Address;
import com.skilldistillery.gatherround.repositories.AddressRepository;

@Service
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	private AddressRepository addressRepo;

	@Override
	public Address show(int addressId) {
		return null;
	}

	@Override
	public Address create(String username, Address address) {
		
		return null;
	}

	@Override
	public Address update(String username, int addressId, Address address) {
		
		return null;
	}

	@Override
	public Address delete(String username, int addressId) {
		
		return null;
	}

}
