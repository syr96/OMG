package com.oracle.OMG.controller;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.OMG.dto.SalesDetail;
import com.oracle.OMG.service.joService.JoSalService;
import com.oracle.OMG.service.joService.Paging;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Data
@Slf4j
@RequestMapping(value = "/sales")
public class JoController {
	
	private final JoSalService jss;
	
	// 판매서 조회
	@RequestMapping(value = "salesInquiry")
	public String salesInquiry(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquiry", "Start");
			int totalSalesInquiry = jss.getTotalSalesInquiry();
			
			Paging page = new Paging(totalSalesInquiry, currentPage);
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> listSalesInquiry = jss.getListSalesInquiry(sales);
			
			model.addAttribute("totalSalesInquiry", totalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("listSalesInquiry", listSalesInquiry);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquiry", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInquriry", "End");
		}
				
		return "jo/salesInquiry";
	}
	
	
	// 판매서 정보
	@RequestMapping("salesInquiryDetail")
	public String salesInquiryDetail(SalesDetail sales, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquiryDetail", "Start");

			SalesDetail salesDetail = jss.getSalesData(sales);					
			List<SalesDetail> salesDetailList = jss.getSalesDetail(sales);
						
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			model.addAttribute("salesDetail", salesDetail);
			model.addAttribute("salesDetailList", salesDetailList);
			model.addAttribute("listCustCode", listCustCode);
						
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquiryDetail Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInquiryDetail", "End");
			
		}
		return "jo/salesInquiryDetail";
	}
	
	
	// 판매서 검색 -> 거래처 or 제품
	@RequestMapping("salesInquirySearch")
	public String salesInquirySearch(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquirySearch", "Start");
			String search  = sales.getSearch();
			String keyword = sales.getKeyword();
			
			int SearchTotalSalesInquiry = jss.getSearchTotalSalesInquiry(sales);
			
			Paging page = new Paging(SearchTotalSalesInquiry, currentPage); 
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesInquirySearch = jss.searchSalesInquiry(sales);
			
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("SearchTotalSalesInquiry", SearchTotalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("salesInquirySearch", salesInquirySearch);
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquirySearch", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInqurirySearch", "End");
		}

		return "jo/salesInquirySearch";
	}
	
	
	// 판매서 분류 -> 전체,진행,취소,완료,출고등록
	@RequestMapping("salesInquirySort")
	public String salesInquirySort(SalesDetail sales, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquirySort", "Start");
						
			int SortTotalSalesInquiry = jss.getSortTotalSalesInquiry(sales.getSales_status());
								
			Paging page = new Paging(SortTotalSalesInquiry, currentPage); 
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesInquirySort = jss.sortSalesInquiry(sales);
			
			model.addAttribute("sortTotalSalesInquiry", SortTotalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("salesInquirySort", salesInquirySort);
			model.addAttribute("sales_status", sales.getSales_status());
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquirySort", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInqurirySort", "End");
		}

		return "jo/salesInquirySort";
	}
	
	
	@RequestMapping(value = "salesDetailDelete", method = RequestMethod.POST)
	public String salesDetailDelete(@RequestParam(value = "salesInfos", required = false) List<String> salesInfos,
	                                @RequestParam(value = "currentPage", required = false) String currentPage,
	                                SalesDetail sales, Model model) {
	    UUID transactionId = UUID.randomUUID();

	    try {
	        log.info("[{}]{}:{}", transactionId, "salesDetailDelete", "Start");

	        if (salesInfos != null && !salesInfos.isEmpty()) {
	            // salesInfos에는 JSON 형태의 문자열이 담겨있습니다. 이를 SalesDetail 객체로 변환하여 사용할 수 있습니다.
	            ObjectMapper objectMapper = new ObjectMapper();
	            List<SalesDetail> salesDetails = salesInfos.stream()
	                    .map(info -> {
	                        try {
	                            return objectMapper.readValue(info, SalesDetail.class);
	                        } catch (JsonProcessingException e) {
	                            e.printStackTrace();
	                            return null;
	                        }
	                    })
	                    .collect(Collectors.toList());

	            // 삭제 처리 로직을 수행하도록 수정
	            int result = jss.deleteSalesDetail((SalesDetail) salesDetails);
	        }

	    } catch (Exception e) {
	        log.error("[{}]{}:{}", transactionId, "salesDetailDelete Exception", e.getMessage());

	    } finally {
	        log.info("[{}]{}:{}", transactionId, "salesDetailDelete", "End");
	    }

	    // 현재 페이지 정보를 사용하여 리다이렉트
	    return "redirect:/jo/salesInquiry?currentPage=" + currentPage;
	}
	

	
	
	  // 판매서 삭제
	  
		/*
		 * @RequestMapping("salesDetailDelete") public String
		 * salesDetailDelete(SalesDetail sales, String currentPage, Model model) { UUID
		 * transactionId = UUID.randomUUID();
		 * 
		 * try { log.info("[{}]{}:{}", transactionId, "salesInquiryDelete", "Start");
		 * int result = jss.deleteSalesDetail(sales);
		 * 
		 * } catch (Exception e) { log.error("[{}]{}:{}", transactionId,
		 * "salesDetailDelete Exception", e.getMessage());
		 * 
		 * } finally { log.info("[{}]{}:{}", transactionId, "salesDetailDelete", "End");
		 * 
		 * } return "redirect:jo/salesInquiry";
		 * 
		 * }
		 */
	 
	 
	
	  
	// 판매서 입력
	@RequestMapping("salesInsertForm")
	public String salesInsertForm(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInsertForm", "Start" );
			
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			List<SalesDetail> listProduct  = jss.getListProduct();
			
			model.addAttribute("listCustCode", listCustCode);
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInsertForm Exception", e.getMessage());
			
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInsertForm", "End" );
		}
		
		return "jo/salesInsertForm";
	}
	
	
	
	  // 판매서 입력
	  @RequestMapping("salesInsert") 
	  public String salesInsert(SalesDetail sales, String currentPage, Model model) { 
		  UUID transactionId = UUID.randomUUID();
		  int result = 0;
	  
		  log.info("sales -> " + sales);
	  
		  try { log.info("[{}]{}:{}", transactionId, "salesInsert", "Start"); 
		  result = jss.InsertSales(sales);
		  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesInsert Exception", e.getMessage()); 
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesInsert", "End"); 
		  }
		  
		  if(result > 0) { 
			  return "redirect:salesInquiry"; 
		  } else {
		  model.addAttribute("msg", "입력실패 확인해보세요"); 
		  return "forward:salesInsertForm"; }
	  
	  }
	 
	  
	// 판매서 수정
	@RequestMapping("salesUpdateForm")
	public String salesUpdateForm(SalesDetail sales, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		System.out.println("JoController salesUpdateForm Start...");
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesUpdateForm", "Start");
			System.out.println("JoController salesUpdateForm Start..." + sales);
			
			SalesDetail salesDetail = jss.getSalesData(sales);
							
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			int totalSalesDetail = jss.getTotalSalesDetail(sales); 
			
			Paging page = new Paging(totalSalesDetail, currentPage);
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesDetailList = jss.getSalesDetail(sales);
			
			model.addAttribute("salesDetail", salesDetail);
			model.addAttribute("page", page);
			model.addAttribute("listCustCode", listCustCode);
			model.addAttribute("salesDetailList", salesDetailList);
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesUpdateForm Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesUpdateForm", "End");		
		}
		return "jo/salesUpdateForm";
	
	}


	// 판매서 수정
	@RequestMapping("salesUpdate")
	public String salesUpdate(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		System.out.println("sales -> " + sales);
		int result = 0;
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesUpdate", "Start");
			result = jss.UpdateSales(sales);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", "salesUpdate Exception", e.getMessage());
			
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesUpdate", "End");		
			
		}
		if(result > 0) {
			return "redirect:salesInquiry";
		} else {
			model.addAttribute("msg", "다시 입력바랍니다.");
			return "forward:salesUpdateForm";
		}
	}
	
	
}
