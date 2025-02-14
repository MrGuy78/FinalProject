package com.skilldistillery.gatherround.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class AddressTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private Address address;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		factory = Persistence.createEntityManagerFactory("GatherRoundJPA");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		factory.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		manager = factory.createEntityManager();
		address = manager.find(Address.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		address = null;
		manager.close();
	}

	@Test
	void test_Address_Entity_Mapping() {
		assertEquals("Spanish Fork Pickleball Courts", address.getName());
	}
	
	@Test
	void test_Address_SocialEvent_OneToMany_Mapping() {
		assertTrue(address.getEvents().size()>0);
	}
}