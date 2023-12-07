package com.oracle.OMG.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class ThController {
	
	@GetMapping("/noticeList")
	public String noticeList(){
		System.out.println("ThController noticeList Start...");
		return "th/noticeList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(){
		System.out.println("ThController noticeDetail Start...");
		return "th/noticeDetail";
	}
	
	@GetMapping("/noticeUpdateForm")
	public String noticeUpdateForm(){
		System.out.println("ThController noticeUpdateForm Start...");
		return "th/noticeUpdateForm";
	}
	
	@GetMapping("/noticeWriteForm")
	public String noticeWriteForm(){
		System.out.println("ThController noticeWriteForm Start...");
		return "th/noticeWriteForm";
	}

	@GetMapping("/QnAList")
	public String QnAList(){
		System.out.println("ThController QnAList Start...");
		return "th/QnAList";
	}	
	
	@GetMapping("/QnADetail")
	public String QnADetail(){
		System.out.println("ThController QnADetail Start...");
		return "th/QnADetail";
	}
	
	@GetMapping("/QnAUpdateForm")
	public String QnAUpdateForm(){
		System.out.println("ThController QnAUpdateForm Start...");
		return "th/QnAUpdateForm";
	}
	
	@GetMapping("/QnAWriteForm")
	public String QnAWriteForm(){
		System.out.println("ThController QnAWriteForm Start...");
		return "th/QnAWriteForm";
	}
}
