package com.oracle.OMG.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class JkController {

	
	// 기초재고등록
	@RequestMapping(value="/invRegister")
	public String invRegister(HttpSession session) {
		System.out.println("JkController invRegister start...");
	
		
		return "jk/invRegister";
		}
}
