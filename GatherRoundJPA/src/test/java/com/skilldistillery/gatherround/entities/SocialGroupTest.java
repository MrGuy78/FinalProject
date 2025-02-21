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

class SocialGroupTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private SocialGroup socialGroup;

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
		socialGroup = manager.find(SocialGroup.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		socialGroup = null;
		manager.close();
	}

	@Test
	void test_SocialGroup_Entity_Mapping() {
		assertEquals("Pickleball Players", socialGroup.getName());
		
	}
	@Test
	void test_SocialGroup_User_ManyToOne_Mapping() {
		assertEquals("Patrick", socialGroup.getOwner().getFirstName());
		
	}
	
	// ***** field Approved in GroupUser needs a "1" *******
	@Test
	void test_SocialGroup_GroupUser_OneToMany_Mapping() {
		assertTrue(socialGroup.getGroupUsers().size()>0);
	}
	
	@Test
	void test_SocialGroup_GroupCategory_ManyToOne_Mapping() {
		assertEquals("Sports", socialGroup.getCategory().getName());
	
	}
	
	@Test
	void test_SocialGroup_GroupComment_OneToMany_Mapping() {
		assertTrue(socialGroup.getComments().size()>0);
	}
	
	@Test
	void test_SocialGroup_SocialEvent_OneToMany_Mapping() {
		assertTrue(socialGroup.getEvents().size()>0);
	}
	
	
	
}