package com.skilldistillery.gatherround.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
		EventUserId eventId  = new EventUserId();
		eventId.setEventId(1);
		eventId.setUserId(1);
		eventUser = manager.find(EventUser.class, eventId);
	}

	@AfterEach
	void tearDown() throws Exception {
		eventUser = null;
		manager.close();
	}

	@Test
	void test_EventUser_Entity_Mapping() {
		assertNotNull(eventUser);
		assertEquals(2025, eventUser.getCreateDate().getYear());
	}
	
}