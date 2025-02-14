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

class UserTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private User user;

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
		user = manager.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		user = null;
		manager.close();
	}

	@Test
	void test_User_Entity_Mapping() {
		assertEquals("pickleballPat", user.getUsername());
		assertTrue(user.isEnabled());
	}
	
	@Test
	void test_User_DirectMessage_Sender_OneToMany_Mapping() {
		assertTrue(user.getSentMessages().size()>0);
	}
	
//	@Test
//	void test_User_DirectMessage_Recipient_OneToMany_Mapping() {
//		assertTrue(user.getReceivedMessages().size()>0);
//	}
	
	@Test
	void test_User_EventComment_OneToMany_Mapping() {
		assertTrue(user.getComments().size()>0);
	}
	
	@Test
	void test_User_EventImage_OneToMany_Mapping() {
		assertTrue(user.getImages().size()>0);
	}
	
}