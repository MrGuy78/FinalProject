package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
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
@Table(name = "social_group")
public class SocialGroup {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "image_url")
	private String imageUrl;

	@CreationTimestamp
	@Column(name = "create_date")
	private LocalDateTime createDate;

	@UpdateTimestamp
	@Column(name = "last_update")
	private LocalDateTime lastUpdate;

	private Boolean enabled;

	@ManyToOne
	@JoinColumn(name = "owner_id")
	private User owner;

	@JsonIgnore
	@OneToMany(mappedBy = "socialGroup")
	private List<GroupUser> groupUsers;

	@ManyToOne
	@JoinColumn(name = "group_category_id")
	private GroupCategory category;

	@JsonIgnore
	@OneToMany(mappedBy = "group")
	private List<GroupComment> comments;

	@JsonIgnore
	@OneToMany(mappedBy = "group")
	private List<SocialEvent> events;

	public SocialGroup() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public List<GroupUser> getGroupUsers() {
		return groupUsers;
	}

	public void setGroupUsers(List<GroupUser> groupUsers) {
		this.groupUsers = groupUsers;
	}

	public GroupCategory getCategory() {
		return category;
	}

	public void setCategory(GroupCategory category) {
		this.category = category;
	}

	public List<GroupComment> getComments() {
		return comments;
	}

	public void setComments(List<GroupComment> comments) {
		this.comments = comments;
	}

	public List<SocialEvent> getEvents() {
		return events;
	}

	public void setEvents(List<SocialEvent> events) {
		this.events = events;
	}

	@Override
	public int hashCode() {
		return Objects.hash(createDate, description, enabled, id, imageUrl, lastUpdate, name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SocialGroup other = (SocialGroup) obj;
		return Objects.equals(createDate, other.createDate) && Objects.equals(description, other.description)
				&& enabled == other.enabled && id == other.id && Objects.equals(imageUrl, other.imageUrl)
				&& Objects.equals(lastUpdate, other.lastUpdate) && Objects.equals(name, other.name);
	}

	@Override
	public String toString() {
		return "SocialGroup [id=" + id + ", name=" + name + ", description=" + description + ", imageUrl=" + imageUrl
				+ ", createDate=" + createDate + ", lastUpdate=" + lastUpdate + ", enabled=" + enabled + "]";
	}

}
