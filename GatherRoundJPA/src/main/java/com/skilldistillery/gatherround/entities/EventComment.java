package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "event_comment")
public class EventComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String comment;
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@UpdateTimestamp
	@Column(name = "last_update")
	private LocalDateTime lastUpdate;
	
	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="event_id")
	private SocialEvent event;
	
	@ManyToOne
	@JoinColumn(name = "in_reply_to_id")
	private EventComment parentComment;
	
	@OneToMany(mappedBy = "parentComment")
	private List<EventComment> subComments;
	
	
//	@JoinColumn(name = "in_reply_to_id")
//	private EventComment commentRepliedTo;
//	

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public EventComment() {
		super();
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

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public SocialEvent getEvent() {
		return event;
	}

	public void setEvent(SocialEvent event) {
		this.event = event;
	}
	
	

	public EventComment getParentComment() {
		return parentComment;
	}

	public void setParentComment(EventComment parentComment) {
		this.parentComment = parentComment;
	}

	public List<EventComment> getSubComments() {
		return subComments;
	}

	public void setSubComments(List<EventComment> subComments) {
		this.subComments = subComments;
	}

	@Override
	public int hashCode() {
		return Objects.hash(comment, createDate, enabled, id, lastUpdate);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EventComment other = (EventComment) obj;
		return Objects.equals(comment, other.comment) && Objects.equals(createDate, other.createDate)
				&& enabled == other.enabled && id == other.id && Objects.equals(lastUpdate, other.lastUpdate);
	}

	@Override
	public String toString() {
		return "EventComment [id=" + id + ", comment=" + comment + ", createDate=" + createDate + ", lastUpdate="
				+ lastUpdate + ", enabled=" + enabled + "]";
	}



	
	
	
}
