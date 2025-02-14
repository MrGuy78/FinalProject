package com.skilldistillery.gatherround.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {
	

}
