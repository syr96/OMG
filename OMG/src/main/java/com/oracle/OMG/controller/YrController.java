package com.oracle.OMG.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.service.yrService.YrItemService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class YrController {
	private final YrItemService yis;
	
	@RequestMapping("/item/list")
	public String itemList(Item item, Model model, HttpSession session) {
		System.out.println("YrController itemList start");
		
		List<Item> itemList = yis.itemList();
		
		model.addAttribute("itemList", itemList);
		
		return "yr/item/itemList";
	}

	// ajax로 구현할 예정
	@RequestMapping("/item/detail")
	public String itemDetail(@RequestParam("code") int code) {
		
		return "yr/item/itemDetail";
	}
	
	@RequestMapping("/item/create")
	public String itemCreate() {
		
		return "yr/item/itemCreate";
	}
}
