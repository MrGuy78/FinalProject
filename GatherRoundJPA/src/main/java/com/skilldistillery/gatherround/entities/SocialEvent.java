package com.skilldistillery.gatherround.entities;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "social_event")
public class SocialEvent {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String description;
	
	@Column(name = "event_date")
	private LocalDate eventDate;
	
	@Column(name = "start_time")
	private LocalTime startTime;
	
	@Column(name = "end_time")
	private LocalTime endTime;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@UpdateTimestamp
	@Column(name = "last_update")
	private LocalDateTime lastUpdate;
	
	private double cost;
	
	private boolean enabled;
	
	@Column(name = "member_only")
	private boolean memberOnly;
	
	@ManyToMany(mappedBy = "event_user")
	private List<User> users;
	

//	@JoinColumn(name = "event_address_id")
//	private Address eventAddress;
//	

	public SocialEvent() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDate getEventDate() {
		return eventDate;
	}

	public void setEventDate(LocalDate eventDate) {
		this.eventDate = eventDate;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public LocalTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
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

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isMemberOnly() {
		return memberOnly;
	}

	public void setMemberOnly(boolean memberOnly) {
		this.memberOnly = memberOnly;
	}

	@Override
	public int hashCode() {
		return Objects.hash(cost, createDate, description, enabled, endTime, eventDate, id, imageUrl, lastUpdate,
				memberOnly, startTime, title);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SocialEvent other = (SocialEvent) obj;
		return Double.doubleToLongBits(cost) == Double.doubleToLongBits(other.cost)
				&& Objects.equals(createDate, other.createDate) && Objects.equals(description, other.description)
				&& enabled == other.enabled && Objects.equals(endTime, other.endTime)
				&& Objects.equals(eventDate, other.eventDate) && id == other.id
				&& Objects.equals(imageUrl, other.imageUrl) && Objects.equals(lastUpdate, other.lastUpdate)
				&& memberOnly == other.memberOnly && Objects.equals(startTime, other.startTime)
				&& Objects.equals(title, other.title);
	}

	@Override
	public String toString() {
		return "SocialEvent [id=" + id + ", title=" + title + ", description=" + description + ", eventDate="
				+ eventDate + ", startTime=" + startTime + ", endTime=" + endTime + ", imageUrl=" + imageUrl
				+ ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + ", cost=" + cost + ", enabled="
				+ enabled + ", memberOnly=" + memberOnly + "]";
	}


}
