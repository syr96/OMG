<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처관리</title>
<%@ include file="/WEB-INF/views/common/menu.jsp"%>    
</head>
<body>
<div class="container">
<div class="container d-flex justify-content-center my-5">
	<div class="d-flex justify-content-center">
		<div class="input-group input-group-merge">
			<input class="form-control form-control-sm" id="keyword" type="search" placeholder="거래처/담당직원 검색" value="${keyword}">
				<div class="input-group-append">
								<!-- 부트스트랩에서 button or div 내 이미지 수평+수직정렬 -->					
					<button class="btn btn-outline-border btn-search d-flex justify-content-center align-items-center"  id="searchButton">						
						<i class="fe fe-search"></i>
					 </button>
				</div>
		</div>		
	</div>
</div>      

<!-- Hoverable Table rows -->
<div class="card">
     <h5 class="card-header">거래처조회</h5>
         <div class="table-responsive text-nowrap">
             <table class="table table-hover">
              <thead>
                   <tr>
                     <th>거래처코드</th>
                     <th>유형</th>
                     <th>구분</th>
                     <th>상호명</th>
                     <th>대표자</th>
                     <th>사업자번호</th>
                     <th>업태</th>
                     <th>업종</th>
                     <th>주소</th>
                     <th>담당직원</th>
                     <th>상세보기</th>
                    </tr>
               </thead>
               <tbody class="table-border-bottom-0">
               <c:forEach var="customer" items="${customerList}">
                    <tr>
                      <td><strong>${customer.custcode}</strong></td>
                      <td>${customer.custstyle == 0 ? '매입' : '매출'}</td>
                        <td>${customer.cust_md == 101? '매입처' : '매출처'}</td>
                        <td>${customer.company }</td>
                        <td>${customer.ceo }</td>
                        <td>${customer.businum}</td>
                        <td>${customer.busitype}</td>
                        <td>${customer.busiitems}</td>
                        <td>${customer.tel}</td>
                        <td>${customer.email}</td>
                        <td><button type="button" class="btn  btn-xs openModalButton" data-toggle="modal" data-target="#Modal" 
                        data-custcode="${customer.custcode}">상세보기</button></td>
                      </tr>
                </c:forEach>
                </tbody>
              </table>
          </div>
</div>
</div>
<!--/ Hoverable Table rows -->





</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>    
</html>