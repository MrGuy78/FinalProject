package com.skilldistillery.gatherround.entities;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class GroupUserId implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "user_id")
	private int userId;

	@Column(name = "group_id")
	private int groupId;

	public GroupUserId() {
		super();
	}

	public GroupUserId(int userId, int groupId) {
		super();
		this.userId = userId;
		this.groupId = groupId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(groupId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		GroupUserId other = (GroupUserId) obj;
		return groupId == other.groupId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "GroupUserId [userId=" + userId + ", groupId=" + groupId + "]";
	}

}
