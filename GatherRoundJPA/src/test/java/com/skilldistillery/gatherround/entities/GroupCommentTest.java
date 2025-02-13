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
}