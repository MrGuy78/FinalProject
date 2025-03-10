package com.skilldistillery.gatherround.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class EventImageTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private EventImage eventImage;

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
		eventImage = manager.find(EventImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		eventImage = null;
		manager.close();
	}

	@Test
	void test_EventImage_Entity_Mapping() {
		assertEquals(1, eventImage.getId());
		
	}
	@Test
	void test_EventImage_ManyToOne_User_Mapping() {
		assertEquals("Patrick", eventImage.getUser().getFirstName());
	}
	
	@Test
	void test_EventImage_ManyToOne_SocialEvent_Mapping() {
		assertEquals("2x2 Pickleball", eventImage.getEvent().getTitle());
	}
	
}