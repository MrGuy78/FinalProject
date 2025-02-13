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
@Table(name = "event_image")
public class EventImage {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	private String caption;

	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="social_event_id")
	private SocialEvent event;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public EventImage() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	
	public SocialEvent getEvent() {
		return event;
	}

	public void setEvent(SocialEvent event) {
		this.event = event;
	}

	@Override
	public int hashCode() {
		return Objects.hash(caption, createDate, id, imageUrl);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EventImage other = (EventImage) obj;
		return Objects.equals(caption, other.caption) && Objects.equals(createDate, other.createDate) && id == other.id
				&& Objects.equals(imageUrl, other.imageUrl);
	}

	@Override
	public String toString() {
		return "EventImage [id=" + id + ", imageUrl=" + imageUrl + ", caption=" + caption + ", createDate=" + createDate
				+ "]";
	}
	
}
