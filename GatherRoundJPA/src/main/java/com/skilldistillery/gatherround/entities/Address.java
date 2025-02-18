package com.skilldistillery.gatherround.entities;

import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Address {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String address;
	
	private String city;
	
	private String state;
	
	private String zip;
	
	@JsonIgnore
	@OneToMany(mappedBy = "meetAddress")
	private List<SocialEvent> events;
	

	public Address() {
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}
	

	public List<SocialEvent> getEvents() {
		return events;
	}

	public void setEvents(List<SocialEvent> events) {
		this.events = events;
	}
	

	@Override
	public int hashCode() {
		return Objects.hash(address, city, id, name, state, zip);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Address other = (Address) obj;
		return Objects.equals(address, other.address) && Objects.equals(city, other.city) && id == other.id
				&& Objects.equals(name, other.name) && Objects.equals(state, other.state)
				&& Objects.equals(zip, other.zip);
	}

	@Override
	public String toString() {
		return "Address [id=" + id + ", name=" + name + ", address=" + address + ", city=" + city + ", state=" + state
				+ ", zip=" + zip + "]";
	}
		
	
}
