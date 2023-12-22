<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>salesInquiry content</title>
		<%@ include file="../common/header.jsp" %>
		<style>
			.button-table-gap {
		        margin-top: 10px; /* 여백 크기 조정 */
		        margin-bottom: 0;
		    }
			
			.table-button-gap {
				margin-top: 0;
				margin-bottom: 0;
			
			}
			
			.button-group {
		        margin-top: -10px; /* 버튼을 위로 올리기 위해 음수 값으로 설정 */
		    }
		    
		</style>
	</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<main>
			<div>
				<h1>판매조회</h1>
			</div>
			
			<!-- Section1: Search Form -->
			<div>
				<form action="salesInquirySearch" method="GET">	
					<div class="row align-items-left">
						<div class="col-md-2">
							<select name="search" class="form-select"  style="margin-left: 0px;">
								<option value="s_company">거래처조회</option>
								<option value="s_item">제품조회</option>
							</select>
						</div>	 
							<div class="col-md-2" style="margin-left: -20px">
								<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
							</div>
							<div class="col-md-4" style="margin-left: -20px">
								<button type="submit" class="btn btn-primary">검색</button>
							</div>	
					</div>
					<input type="hidden" name="currentPage" value="${page.currentPage}">	
				</form>
			</div>
												
			<!-- Section2: Table -->		
			<div>
				<div class="button-table-gap">
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='../sales/salesInquiry'">전체</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='../sales/salesInquirySort?sales_status=0'">진행</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='../sales/salesInquirySort?sales_status=1'">완료</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='../sales/salesInquirySort?sales_status=2'">취소</button>
				</div>
			<div>	
				<div class="table-button-gap">
				<table style="border: 2px solid black; width: 100%" id="userTable" class="table table-md text-center p-3">
					<thead>
						<tr style="border: 2px solid black; background-color: #696cff; color: #fff;">
							<th scope="col" style="text-align: center;"><input type="checkbox" name="allCheck" id="allCheck" onchange="checkAll(this)"/></th>
							<th scope="col" style="text-align: center;">No.</th>
							<th scope="col" style="text-align: center;">매출일자</th>
							<th scope="col" style="text-align: center;">제목</th>
							<th scope="col" style="text-align: center;">거래처</th>
							<th scope="col" style="text-align: center;">제품</th>
							<th scope="col" style="text-align: center;">총 금액</th>
							<th scope="col" style="text-align: center;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="salesInquirySearch" items="${salesInquirySearch}">
							<tr>
								<td style="text-align: center"><input type="checkbox" name="rowCheck" value="${salesInquirySearch.sales_date}"/></td>
								<td style="text-align: center">${num}</td>
								<td style="text-align: center">${salesInquirySearch.sales_date}</td>
						  		<td><a href="salesInquiryDetail?sales_date=${salesInquirySearch.sales_date}&custcode=${salesInquirySearch.custcode}">${salesInquirySearch.title}</a></td>
						  		<td style="text-align: center">${salesInquirySearch.company}</td>
								<td style="text-align: center">${salesInquirySearch.name}</td>
								<td style="text-align: center">${salesInquirySearch.total_price}</td>
								<td style="text-align: center">
									<c:if test="${salesInquirySearch.sales_status == 0}">진행</c:if>
									<c:if test="${salesInquirySearch.sales_status == 1}">완료</c:if>
									<c:if test="${salesInquirySearch.sales_status == 2}">취소</c:if>
									<c:if test="${salesInquirySearch.sales_status == 3}">입고완료</c:if>
								</td>
							</tr>
						<c:set var="num" value="${num + 1}"/>
						</c:forEach>
					</tbody>
				</table>
				</div>
				</div>
				<div class="button-group">
					<button id="selectBtn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='salesInsertForm'">신규</button>
					<input type="button" value="삭제" class="btn btn-primary btn-sm mb-1" onclick="deleteSelected();">
					<!-- Section3: Paging -->
					<div class=" container text-center" id="staticPagination">
				     <ul class="pagination pagination-sm justify-content-center">
				        <c:if test="${page.startPage > page.pageBlock }">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="salesInquiry?currentPage=${page.startPage-page.pageBlock }">
				                    <i class="fa fa-caret-left"></i>
				                </a>
				            </li>
				        </c:if>
				
				        <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
				            <li class="page-item <c:if test='${page.currentPage == i}'>active</c:if>">
				                <a class="page-link" href="salesInquiry?currentPage=${i}">${i}</a>
				            </li>
				        </c:forEach>
				
				        <c:if test="${page.endPage > page.totalPage }">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="salesInquiry?currentPage=${page.startPage+page.pageBlock }">
				                    <i class="fa fa-caret-right"></i>
				                </a>
				            </li>
				        </c:if>
				    </ul>
				</div>		             
			<%-- <!-- Section3: Paging -->
			<c:if test="${page.startPage > page.pageBlock }">
				<a href="salesInquirySearch?search=${search}&keyword=${keyword}&currentPage=${page.startPage-page.pageBlock }">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
				<a href="salesInquirySearch?search=${search}&keyword=${keyword}&currentPage=${i}">[${i}]</a>
			</c:forEach>	
			<c:if test="${page.endPage < page.totalPage }">
				<a href="salesInquirySearch?search=${search}&keyword=${keyword}&currentPage=${page.startPage+page.pageBlock }">[다음]</a>
			</c:if> --%>
			</div>
		</div>				
		</main>
 	 </div>
  </div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>