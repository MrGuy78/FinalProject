package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "direct_message")
public class DirectMessage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String comment;
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@ManyToOne
	@JoinColumn(name="sender_id")
	private User sender;
	
	@ManyToOne
	@JoinColumn(name="recipient_id")
	private User recipient;
	

	public User getReceipent() {
		return recipient;
	}



	public void setReceipent(User receipent) {
		this.recipient = receipent;
	}



	public DirectMessage() {
		super();
	}



	public User getSender() {
		return sender;
	}



	public void setSender(User sender) {
		this.sender = sender;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	@Override
	public int hashCode() {
		return Objects.hash(comment, createDate, id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DirectMessage other = (DirectMessage) obj;
		return Objects.equals(comment, other.comment) && Objects.equals(createDate, other.createDate) && id == other.id;
	}

	@Override
	public String toString() {
		return "DirectMessage [id=" + id + ", comment=" + comment + ", createDate=" + createDate + "]";
	}
	
	
	
}
