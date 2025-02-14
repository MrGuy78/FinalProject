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

class SocialEventTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private SocialEvent socialEvent;

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
		socialEvent = manager.find(SocialEvent.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		socialEvent = null;
		manager.close();
	}

	@Test
	void test_SocialEvent_Entity_Mapping() {
		assertEquals("2x2 Pickleball", socialEvent.getTitle());
	}
	
	@Test
	void test_SocialEvent_ManyToOne_User_Mapping() {
		assertEquals("Ben", socialEvent.getUser().getFirstName());
	}
	
	
	
}