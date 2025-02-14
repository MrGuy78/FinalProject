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

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private boolean enabled;

	private String role;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String email;

	private String phone;

	@Column(name = "image_url")
	private String imageUrl;

	private String biography;

	@CreationTimestamp
	@Column(name = "create_date")
	private LocalDateTime createDate;

	@UpdateTimestamp
	@Column(name = "last_update")
	private LocalDateTime lastUpdate;

	@JsonIgnore
	@OneToMany(mappedBy = "sender")
	private List<DirectMessage> sentMessages;

	@JsonIgnore
	@OneToMany(mappedBy = "recipient")
	private List<DirectMessage> receivedMessages;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<EventComment> comments;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<EventImage> images;

	@OneToMany(mappedBy = "user")
	private List<EventUser> eventUsers;

	@OneToMany(mappedBy = "user")
	private List<SocialEvent> events;

	@OneToMany(mappedBy = "user")
	private List<GroupUser> groupUsers;

	@OneToMany(mappedBy = "owner")
	private List<SocialGroup> socialGroups;

	@OneToMany(mappedBy = "user")
	private List<GroupComment> groupComments;

	@ManyToOne
	@JoinColumn(name = "address_id")
	private Address address;

	public User() {
		super();
	}

	public List<EventUser> getEventUsers() {
		return eventUsers;
	}

	public void setEventUsers(List<EventUser> eventUsers) {
		this.eventUsers = eventUsers;
	}

	public List<EventComment> getComments() {
		return comments;
	}

	public void setComments(List<EventComment> comments) {
		this.comments = comments;
	}

	public List<EventImage> getImages() {
		return images;
	}

	public void setImages(List<EventImage> images) {
		this.images = images;
	}

	public List<DirectMessage> getReceivedMessages() {
		return receivedMessages;
	}

	public void setReceivedMessages(List<DirectMessage> receivedMessages) {
		this.receivedMessages = receivedMessages;
	}

	public List<DirectMessage> getSentMessages() {
		return sentMessages;
	}

	public void setSentMessages(List<DirectMessage> messages) {
		this.sentMessages = messages;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<SocialEvent> getEvents() {
		return events;
	}

	public void setEvents(List<SocialEvent> events) {
		this.events = events;
	}

	public List<GroupUser> getGroupUsers() {
		return groupUsers;
	}

	public void setGroupUsers(List<GroupUser> groupUsers) {
		this.groupUsers = groupUsers;
	}

	public List<SocialGroup> getSocialGroups() {
		return socialGroups;
	}

	public void setSocialGroups(List<SocialGroup> socialGroups) {
		this.socialGroups = socialGroups;
	}

	public List<GroupComment> getGroupComments() {
		return groupComments;
	}

	public void setGroupComments(List<GroupComment> groupComments) {
		this.groupComments = groupComments;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", phone=" + phone + ", imageUrl=" + imageUrl + ", biography=" + biography + ", createDate="
				+ createDate + ", lastUpdate=" + lastUpdate + "]";
	}

}
