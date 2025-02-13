package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "group_user")
public class GroupUser {

	private boolean approved;
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@Column(name = "approved_date")
	private LocalDateTime approvedDate;
	
	private boolean leader;
	

	public GroupUser() {
		super();
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getApprovedDate() {
		return approvedDate;
	}

	public void setApprovedDate(LocalDateTime approvedDate) {
		this.approvedDate = approvedDate;
	}

	public boolean isLeader() {
		return leader;
	}

	public void setLeader(boolean leader) {
		this.leader = leader;
	}

	@Override
	public int hashCode() {
		return Objects.hash(approved, approvedDate, createDate, leader);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		GroupUser other = (GroupUser) obj;
		return approved == other.approved && Objects.equals(approvedDate, other.approvedDate)
				&& Objects.equals(createDate, other.createDate) && leader == other.leader;
	}

	@Override
	public String toString() {
		return "GroupUser [approved=" + approved + ", createDate=" + createDate + ", approvedDate=" + approvedDate
				+ ", leader=" + leader + "]";
	}
	
	

}
