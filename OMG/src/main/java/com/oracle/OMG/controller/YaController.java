package com.oracle.OMG.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.service.yaService.YaCustomerService;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
@RequiredArgsConstructor
public class YaController {
	private final YaCustomerService ycs;

	@RequestMapping(value="/customerList")
	public String customerList(Customer customer, Model model, String currentPage) {
	System.out.println("YaController customerList start...");
		List<Customer>customerList = null;
		customerList = ycs.customerList(customer);
		model.addAttribute("customerList", customerList);
	
	return "ya/customer";
		
	}

	
	
}
