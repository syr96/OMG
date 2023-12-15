package com.oracle.OMG.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.OMG.dto.Member;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class ShController {
	
	@RequestMapping(value = "/")
	public String main() {
		return "main";
	}

	@RequestMapping(value = "memberR")
	public String memberRegistration() {
		return "sh/memberRegistration";
	}
	
	@RequestMapping(value = "memberU")
	public String memberUpdate() {
		return "sh/memberUpdate";
	}
	
	@RequestMapping(value = "memberL")
	public String memberList() {
		return "sh/memberList";
	}
	
	@RequestMapping(value = "example")
	public String example() {
		return "example";
	}
	
	@RequestMapping(value = "pwdCheck")
	public String pwdCheck(@RequestParam("userPwd") String userPwd, Model model) {
		//결과값 들어갈 변수
		String result = "";
		
		//특정 문구 제한
		if(userPwd.contains("1004")||userPwd.contains("8282")||userPwd.contains("abc123")) {
			System.out.println("위험 - 특정 문구 포함 불가");
			result = "2";
		} else if(userPwd.matches("^[a-zA-Z]*$")||userPwd.matches("^[0-9]*$")){
			System.out.println("보통 - 영문자, 숫자만 있을 경우");
			result = "3";
		} else {
			System.out.println("안전 - 영문자, 숫자, 특수문자 중 2개 이상 조합");
			result = "4";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "createMember")
	public String createMember(@RequestParam("right") int right,
							   @RequestParam("hiredate") Date hiredate,
							   @RequestParam("name") String name,
							   @RequestParam("birthday") String birthday,
							   @RequestParam("sex") String sex,
							   @RequestParam("email") String email,
							   @RequestParam("phone") String phone,
							   @RequestParam("dept") int dept,
							   @RequestParam("posi") int posi,
							   @RequestParam("duty") int duty,
							   @RequestParam("mailcode") int mailcode,
							   @RequestParam("address") String address,
							   @RequestParam("password") String paasword,
							   @RequestParam("img") MultipartFile img,
							   HttpServletRequest request,
							   Model model) throws IOException {
		String result = null;
		
		Member member = new Member();
		member.setMem_right(right);
		member.setMem_hiredate(hiredate);
		member.setMem_name(name);
		member.setMem_bd(birthday);
		member.setMem_sex(sex);
		member.setMem_email(email);
		member.setMem_phone(phone);
		member.setMem_dept_md(dept);
		member.setMem_posi_md(posi);
		member.setMem_duty_md(duty);
		member.setMem_mailcode(mailcode);
		member.setMem_address(address);
		member.setMem_pw(paasword);
		
		return result;
 	}
}
