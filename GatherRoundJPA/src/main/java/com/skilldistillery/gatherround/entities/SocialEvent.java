package com.skilldistillery.gatherround.entities;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

	private Double cost;

	private boolean enabled;

	@Column(name = "member_only")
	private boolean memberOnly;

	// JsonProperties? to see userId associated with group
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "meet_address_id")
	private Address meetAddress;

	@ManyToOne
	@JoinColumn(name = "event_address_id")
	private Address eventAddress;

	// JsonProperties? to see groupId associated with group
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "social_group_id")
	private SocialGroup socialGroup;

	@JsonIgnore
	@OneToMany(mappedBy = "event")
	private List<EventUser> eventUsers;

	@JsonIgnore
	@OneToMany(mappedBy = "event")
	private List<EventImage> images;

	@JsonIgnore
	@OneToMany(mappedBy = "event")
	private List<EventComment> comments;

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

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Address getMeetAddress() {
		return meetAddress;
	}

	public void setMeetAddress(Address address) {
		this.meetAddress = address;
	}

	public SocialGroup getSocialGroup() {
		return socialGroup;
	}

	public void setSocialGroup(SocialGroup group) {
		this.socialGroup = group;
	}

	public List<EventUser> getEventUsers() {
		return eventUsers;
	}

	public void setEventUsers(List<EventUser> eventUsers) {
		this.eventUsers = eventUsers;
	}

	public List<EventImage> getImages() {
		return images;
	}

	public void setImages(List<EventImage> images) {
		this.images = images;
	}

	public List<EventComment> getComments() {
		return comments;
	}

	public void setComments(List<EventComment> comments) {
		this.comments = comments;
	}

	public Address getEventAddress() {
		return eventAddress;
	}

	public void setEventAddress(Address eventAddress) {
		this.eventAddress = eventAddress;
	}

	

	@Override
	public int hashCode() {
		return Objects.hash(id);
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
		return id == other.id;
	}

	@Override
	public String toString() {
		return "SocialEvent [id=" + id + ", title=" + title + ", description=" + description + ", eventDate="
				+ eventDate + ", startTime=" + startTime + ", endTime=" + endTime + ", imageUrl=" + imageUrl
				+ ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + ", cost=" + cost + ", enabled="
				+ enabled + ", memberOnly=" + memberOnly + "]";
	}

}
