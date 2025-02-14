package com.skilldistillery.gatherround.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
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
	
	
	// ******  Need to add response in direct message table   ****** 
	@Test
	void test_User_DirectMessage_Recipient_OneToMany_Mapping() {
		assertTrue(user.getReceivedMessages().size()>0);
	}
	
	@Test
	void test_User_EventComment_OneToMany_Mapping() {
		assertTrue(user.getComments().size()>0);
	}
	
	@Test
	void test_User_EventImage_OneToMany_Mapping() {
		assertTrue(user.getImages().size()>0);
	}
	
	// ******  Need to add data into Event User table   ****** 
	@Test
	void test_User_EventUser_OneToMany_Mapping() {
		assertTrue(user.getEventUsers().size()>0);
	}
	
	@Test
	void test_User_SocialEvent_OneToMany_Mapping() {
		assertTrue(user.getEvents().size()>0);
	}
	
	//  ******  Need to change "approved" field to "1" since boolean   ****** 
	@Test
	void test_User_GroupUser_OneToMany_Mapping() {
		assertTrue(user.getGroupUsers().size()>0);
	}
	
	@Test
	void test_User_SocialGroup_OneToMany_Mapping() {
		assertTrue(user.getSocialGroups().size()>0);
	}
	
	@Test
	void test_User_GroupComment_OneToMany_Mapping() {
		assertTrue(user.getGroupComments().size()>0);
	}
	
	void test_User_Address_OneToOne_Mapping() {
		assertNull(user.getAddress().getName());
	}
	
}