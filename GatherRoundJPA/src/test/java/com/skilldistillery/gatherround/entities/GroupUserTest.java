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

class GroupUserTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private GroupUser groupUser;

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
		GroupUserId gId = new GroupUserId();
		gId.setGroupId(1);
		gId.setUserId(1);
		groupUser = manager.find(GroupUser.class, gId);
	}

	@AfterEach
	void tearDown() throws Exception {
		groupUser = null;
		manager.close();
	}

	// ***** field Approved needs a "1", add a date for create_date too
	@Test
	void test_GroupUser_Entity_Mapping() {
		assertNotNull(groupUser);
		assertEquals(2025, groupUser.getCreateDate().getYear());
	}
	
	// ***** field Approved needs a "1" *******
	@Test
	void test_GroupUser_ManyToOne_User_mapping() {
	assertEquals(1, groupUser.getId().getUserId());
	}
	
	
}