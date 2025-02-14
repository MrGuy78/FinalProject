package com.skilldistillery.gatherround.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class GroupCommentTest {

	private static EntityManagerFactory factory;
	private EntityManager manager;
	private GroupComment groupComment;

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
		groupComment = manager.find(GroupComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		groupComment = null;
		manager.close();
	}

	@Test
	void test_GroupComment_Entity_Mapping() {
		assertEquals("Hey group", groupComment.getComment());
		
	}
	
	@Test
	void test_GroupComment_User_ManyToOne_Mapping() {
		assertEquals("Ben", groupComment.getUser().getFirstName());
	}
	
	// ******* Add 2nd comment to reply to 1st comment ********
	@Test
	void test_ParentComment_to_SubComments_ManyToOne_mapping() {
		groupComment = manager.find(GroupComment.class, 2);
		assertNotNull(groupComment);
		assertNotNull(groupComment.getParentComment());
		assertEquals(1,groupComment.getParentComment().getId()); 
	}
	
	// ******* Add 2nd comment to reply to 1st comment ********
	@Test
	void test_MealComment_SubComments_OneToMany_mapping() {
		assertNotNull(groupComment.getSubComments());
		assertTrue(groupComment.getSubComments().size()>0);
	}
	
}