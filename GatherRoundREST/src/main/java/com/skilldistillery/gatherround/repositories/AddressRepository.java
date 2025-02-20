package com.skilldistillery.gatherround.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.gatherround.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {

	List<Address> findByEvents_SocialGroup_Id(int groupId);

}
