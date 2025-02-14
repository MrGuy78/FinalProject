package com.skilldistillery.gatherround.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.gatherround.services.AddressService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class AddressController {
	
	@Autowired
	private AddressService addressService;
	
//	@GetMapping("addresses/{addressId}")
//	public Address show(@PathVariable("addressId") Integer addressId, 
//						HttpServletRequest requ, 
//						HttpServletResponse resp,  
//						Principal principal) {
//		Address address = null;
//		
//		try {
//			address = addressService.show(principal.getName(), addressId);
//				resp.setStatus(HttpServletResponse.SC_OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
//		}
//		return address;
//	}
	
	

}
