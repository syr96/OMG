package com.oracle.OMG.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class YrController {
	
	@RequestMapping("/item/list")
	public String itemList() {
		
		
		return "yr/item/itemList";
	}

	// ajax로 구현할 예정
	@RequestMapping("/item/detail")
	public String itemDetail() {
		
		return "yr/item/itemDetail";
	}
	
	@RequestMapping("/item/create")
	public String itemCreate() {
		
		return "yr/item/itemCreate";
	}
}
