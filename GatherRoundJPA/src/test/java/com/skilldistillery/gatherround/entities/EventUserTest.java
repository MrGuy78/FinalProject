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

class EventUserTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private EventUser eventUser;

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
		EventUserId eId  = new EventUserId();
		eId.setEventId(1);
		eId.setUserId(1);
		eventUser = manager.find(EventUser.class, eId);
	}

	@AfterEach
	void tearDown() throws Exception {
		eventUser = null;
		manager.close();
	}

	@Test
	void test_EventUser_Entity_Mapping() {
		
	}
	
	
}