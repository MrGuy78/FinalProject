package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="event_user")
public class EventUser {
	
	@EmbeddedId
	private EventUserId id;

	private boolean attending;
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	private int rating;
	
	private String remarks;
	
	@ManyToOne
	private User user;

	public EventUser() {
		super();
	}
	
	public EventUserId getId() {
		return id;
	}

	public void setId(EventUserId id) {
		this.id = id;
	}

	public boolean isAttending() {
		return attending;
	}

	public void setAttending(boolean attending) {
		this.attending = attending;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String text) {
		this.remarks = text;
	}

	@Override
	public int hashCode() {
		return Objects.hash(attending, createDate, id, rating, remarks);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EventUser other = (EventUser) obj;
		return attending == other.attending && Objects.equals(createDate, other.createDate)
				&& Objects.equals(id, other.id) && rating == other.rating && Objects.equals(remarks, other.remarks);
	}

	@Override
	public String toString() {
		return "EventUser [id=" + id + ", attending=" + attending + ", createDate=" + createDate + ", rating=" + rating
				+ ", text=" + remarks + "]";
	}
	
	
}
