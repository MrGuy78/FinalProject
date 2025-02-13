package com.skilldistillery.gatherround.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;

@Entity
@Table(name = "group_comment")
public class GroupComment {

	private String comment;
	
	
	@CreationTimestamp
	@Column(name = "create_date") 
	private LocalDateTime createDate;
	
	@UpdateTimestamp
	@Column(name = "last_update")
	private LocalDateTime lastUpdate;
	
	private boolean enabled;
	
	@JoinColumn(name = "in_reply_to_id")
	private GroupComment commentRepliedTo;

	public GroupComment() {
		super();
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

	public GroupComment getCommentRepliedTo() {
		return commentRepliedTo;
	}

	public void setCommentRepliedTo(GroupComment commentRepliedTo) {
		this.commentRepliedTo = commentRepliedTo;
	}

	@Override
	public int hashCode() {
		return Objects.hash(comment, commentRepliedTo, createDate, enabled, lastUpdate);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		GroupComment other = (GroupComment) obj;
		return Objects.equals(comment, other.comment) && Objects.equals(commentRepliedTo, other.commentRepliedTo)
				&& Objects.equals(createDate, other.createDate) && enabled == other.enabled
				&& Objects.equals(lastUpdate, other.lastUpdate);
	}

	@Override
	public String toString() {
		return "GroupComment [comment=" + comment + ", createDate=" + createDate + ", lastUpdate=" + lastUpdate
				+ ", enabled=" + enabled + ", commentRepliedTo=" + commentRepliedTo + "]";
	}
	
	
}
