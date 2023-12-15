package com.oracle.OMG.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Member;
import com.oracle.OMG.service.thService.Paging;
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
	//거래처 전체조회
	@RequestMapping(value="/customerList")
	public String customerList(Customer customer, Model model, String currentPage) {
	System.out.println("YaController customerList start...");
	
		int totalCustomer = 0;
		totalCustomer = ycs.totalCustomer(customer);
		System.out.println("YaContorller totalCustomer->"+ totalCustomer);
		
		Paging custPage = new Paging(totalCustomer, currentPage, 10);
		customer.setStart(custPage.getStart());
		customer.setEnd(custPage.getEnd());
		
		List<Customer>customerList = null;
		customerList = ycs.customerList(customer);
		
		
		model.addAttribute("totalCustomer", totalCustomer);
		model.addAttribute("custPage", custPage);
		model.addAttribute("customerList", customerList);
		
		
	return "ya/customer";	
	}
	
	//거래처 상세보기
	@GetMapping("/customerDetail")
	@ResponseBody
	public Map<String, Object> customerDetail(@RequestParam("custcode")int custcode) {
		System.out.println("YaController Start customerDetail start...");
		
		Map<String, Object> result = new HashMap<>();
		
		Customer customer = ycs.customerDetail(custcode);
		System.out.println("YaConroller detailCustomer custcode:"+customer.getCustcode());
		System.out.println("YaConroller detailCustomer company:"+customer.getCompany());	
		
		result.put("customer", customer);
		return result;
	}
	
	//직원 전체조회 ( 거래처수정용) 
	@PostMapping("/memberList")
	@ResponseBody
	public Map<String, Object> memberList(@RequestBody Member member){
		Map<String, Object> result = new HashMap<>();
		
		List<Member> memberList = null;
		memberList = ycs.memberList(member);
		result.put("memberList", memberList);
	
		return result;
	}
	
	//거래처 전체조회 
	@PostMapping("/customerListSelect")
	@ResponseBody
	public Map<String, Object> customerListSelect(@RequestBody Customer customer){
		Map<String, Object> result = new HashMap<>();
		
		List<Customer> customerListSelect = null;
		customerListSelect = ycs.customerListSelect(customer);
		result.put("customerListSelect", customerListSelect);
	
		return result;
	}	
	//거래처 정보수정
	@PostMapping("/updateCustomer")
	@ResponseBody
	public Map<String,Object> updateCustomer(@RequestBody Customer customer){
		 Map<String, Object> result = new HashMap<>();
		 
		 customer =  ycs.updateCustomer(customer);		  
		 result.put("success", true);
			
		return result;
				
	}
	
	//거래처 등록
	@RequestMapping(value="/insertCustomer")
	@ResponseBody
	public Map<String, Object> insertCustomer(@RequestBody Customer customer){
		 Map<String, Object> result = new HashMap<>();
		 
		 customer = ycs.insertCustomer(customer);
		 result.put("success", true);
		 
		 
		return result;
		 
	}
	
	//거래처삭제
	@GetMapping("/deleteCustomer")
	public String deleteCustomer(int custcode, Model model) {
		int deleteResult = ycs.deleteCustomer(custcode);
		System.out.println("YaController ycs.deleteCustomer start...");
		
		return "redirect:customerList";
	}
	
	//거래처 검색
	@GetMapping("/customerSearch")
	@ResponseBody
	public Map<String, Object> customerSearch(HttpServletRequest request){
		System.out.println("YaController ycs.customerSearch Start...");
		String keyword=request.getParameter("keyword");
		String currentPage = request.getParameter("currentPage");
		
		System.out.println("kewyord?:"+keyword);
		
		
		int totalSearch = ycs.totalSearch(keyword);
		System.out.println("YaController totalSearch(keyword):"+totalSearch);
					
		Paging paging = new Paging(totalSearch, currentPage);
		List<Customer> customerSearchList = ycs.customerSearch(keyword,paging.getStart(), paging.getEnd());
		
		Map<String, Object> result = new HashMap<>();
		result.put("customerSearchList", customerSearchList);
		result.put("paging",paging);
		
		return result;
	}
	
	//거래처판매실적 전체조회
	@GetMapping("/customerSales")
	/* @ResponseBody */
	public String customerSalesList(Customer customer, Model model) {
		System.out.println("YaController ycs.custoemrSales start...");
		List<Customer> customerSalesList = ycs.customerSalesList(customer);
		model.addAttribute("customerSalesList", customerSalesList);

		 return "ya/salesByCustomer";
	}
	
	//판매상세테이블 월별 매출액
	@RequestMapping("/salesMonths")
	public String salesMonths(Model model,String sales_date) {
	    String salesMonths =ycs.salesMonths(sales_date); 
	    model.addAttribute("salesMonths", salesMonths);
		//주문상세테이블 월	
	    return"ya/salesByCustomer";
	}

	//주문상세테이블 월별 매입액
	@RequestMapping("/purMonths")
	public String purMonths(Model model,String pur_date) {
	    String purMonths =ycs.purMonths(pur_date); 
	    model.addAttribute("purMonths", purMonths);
		//주문상세테이블 월	
	    return"ya/salesByCustomer";
	}	

	//거래처,월별,유형별 판매실적 검색
	@GetMapping("/customerSalesSearch")
	@ResponseBody
	public Map<String, Object> customerSalesSearch(HttpServletRequest request){
		System.out.println("YaController ycs.customerSearch Start...");
		int custcode =Integer.parseInt(request.getParameter("custcode"));
		String month = request.getParameter("month");
		String purDate = request.getParameter("purDate");
		String custstyle = request.getParameter("custstyle");
		
		/*
		 * // custcode가 0이면 거래처 전체조회하기 if (custcode == 0) { custcode = 0; }
		 * 
		 * // 월이 "all"로 전달된 경우 거래일자 전체조회하기 if ("all".equals(month)) { month = null; }
		 * 
		 * // 구분이 "전체"일 경우 매입0 매출1 전체조회하기 if ("all".equals(custstyle)) { custstyle =
		 * null; }
		 */
	
		List<Customer> customerSalesSearch = ycs.customerSalesSearch(custcode,month,custstyle,purDate);
		
	
		
		Map<String, Object> result = new HashMap<>();
		result.put("customerSalesSearch", customerSalesSearch);
		/*
		 * result.put("monthlyPurchaseTotals", monthlyPurchaseTotals);
		 * result.put("monthlySalesTotals", monthlySalesTotals);
		 */

		System.out.println("customerSalesSearch size:"+ customerSalesSearch.size());
		System.out.println("customerSalesSearch custcode:"+custcode);
		System.out.println("customerSalesSearch  month:"+ month);
		System.out.println("customerSalesSearch  custstyle:"+ custstyle);
		/* System.out.println("monthlySalesTotals:"+monthlySalesTotals); */
		
		return result;
		
	}

}
