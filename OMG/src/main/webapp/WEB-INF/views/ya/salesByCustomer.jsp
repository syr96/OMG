<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>        
<!DOCTYPE html>
<html>
<head>
    <style>
        /* 스크롤 테이블 관련 스타일 */
        .table-container {
            overflow-x: auto; /*좌우스크롤  */
            overflow-y: auto; /* 세로 스크롤 추가 */
            max-height: 600px; 
            position: relative; 
        }
        
        #tableBody {
        white-space: nowrap;
        }
 
		 .fixed-tfoot {
		    position: sticky;
		    bottom: 0;
		    background-color: #f8f9fa;
		    z-index: 1;
		    white-space: nowrap;
		
		}

 	   .fixed-thead {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
             white-space: nowrap;
        }

        /* 추가: THEAD 내 TH에도 백그라운드 색상 지정 */
        .fixed-thead th {
            background-color: #f8f9fa;
             position: sticky;
        }
    </style>

<meta charset="UTF-8">
<title>거래처실적조회</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<%@ include file="/WEB-INF/views/common/menu.jsp"%>    
</head>

    <!-- 스크롤 이벤트 처리를 위한 JavaScript 코드 -->
    <script>
        $(document).ready(function () {
            // 스크롤 이벤트 발생 시 고정 THEAD 업데이트
            $(".table-container").scroll(function () {
                $(".fixed-thead").css("left", -$(".table-container").scrollLeft());
            });
        });
    </script>
    
<body>
<div class="container">
<div class="col-lg">
<div class="card">
  <h5 class="card-header">거래처별실적조회</h5>
   <div class="row mx-3" >	   
		<div class="col-12 mb-3 d-flex justify-content-center justify-content-md-between">	  		   
		    <label for="selectOption">조회기간: </label>
		    <label for="month">
		    <input class="form-control" type="month" id="monthSelect" name="month">
		    </label>
		
		    <label>구분: </label>		    
		    <select class="form-select" style="width: 100px;">
		    	<option value=" ">전체</option>
		    	<option value="0">매입</option>
		    	<option value="1">매출</option>
		    </select>
			
			<label for="searchSelect">거래처명: </label>
				<select class="form-select" id="in_custcode" style="width: 200px; " ></select>
			<button class="btn btn-sm btn-outline-primary" id="searchButton" type="button" onclick="search()" style="height:30px;">검색</button>
		</div>	
    </div>

 <script>

	    
$(document).ready(function () {
	
	
	//거래처리스트 
    $.ajax({
        url: '/customerListSelect',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
        	custcode: $('#in_custcode').val(),
        }),
        success: function (response) {
        	var customerListSelect = response.customerListSelect;
        	
        	  // "전체" 옵션 추가
            $('#in_custcode').append('<option value=" ">전체</option>');
            for (var i = 0; i < customerListSelect.length; i++) {
            	$('#in_custcode').append('<option value="' +  customerListSelect[i].custcode + '">' +  customerListSelect[i].custcode + 
            			'  ' +  customerListSelect[i].company + '</option>');
            }
        },
        error: function () {
            console.error('서버 오류');
        }
    });
});


function search() {
   
	// 선택한 월을 추출
    var selectedMonth = document.getElementById("monthSelect").value;
    var month = selectedMonth.split("-")[1];
    var selectedCustcodes = $('#in_custcode').val();
    // 선택한 구분을 추출
    var selectedType = $('.form-select').val();
    console.log("Selected Month:", month);
    
    // 월을 선택하지 않았을 경우
    if (selectedMonth === "") {
        month = "all";
    }

    // 구분을 선택하지 않았을 경우
    if (selectedType === "") {
        selectedType = "all";
    }
    // Ajax 요청
    $.ajax({
        url: '/customerSalesSearch',
        type: 'GET',
        data: {
	            custcode: selectedCustcodes,
	            month:  month,
	            custstyle: selectedType,
            	//purDate:  
        },
        success: function (data) {
            // 서버 응답에 대한 처리
            console.log("Search successful:", data);
            var customerSalesSearch = data.customerSalesSearch;


            // 검색결과 
            $("#searchResultsTable tbody").empty();
            $.each(customerSalesSearch, function (index, customer) {
                var row = "<tr>" +
                    "<td>" + customer.month + "</td>" +
                    "<td>" + customer.purDate + "</td>" +
                    "<td>" + (customer.custstyle == 0 ? '매입' : '매출') + "</td>" +
                    "<td>" + customer.custcode + "</td>" +
                    "<td>" + customer.company + "</td>" +
                    "<td>" + customer.purCode + "</td>" +
                    "<td>" + customer.itemName + "</td>" +
                    "<td>" + customer.purQty + "</td>" +
                    "<td>" + customer.purPrice.toLocaleString()  + "</td>" +
                    "<td>" + (customer.custstyle == 0 ? (customer.purQty * customer.purPrice).toLocaleString() : '-') + "</td>" +
                    "<td>" + (customer.custstyle == 1 ? (customer.purQty * customer.purPrice).toLocaleString() : '-') + "</td>" +
                    "</tr>";
                    
                    
                $("#searchResultsTable tbody").append(row);
            });
            
            
        },
        error: function () {
            console.error('서버 오류');
        }
    });
}

</script>
  
    		
  <div class="table-responsive text-nowrap mx-3 ">
  <div class="table-container">
           <table id="searchResultsTable" class=" table table-hover">
           <thead class="fixed-thead"> 
                   <tr>
                     <th style="width: 60.508px;">월</th>
                     <th style="width: 119.508px;">거래일자</th> 
                     <th style="width: 100px;">유형</th>
                     <th style="width: 119.508px;">거래처코드</th>
                     <th style="width: 300px;" >거래처명</th>
                    <!-- <th style="width: 119.508px;">사업자번호</th> -->
                    
                     <th  style="width: 119.508px;">제품코드</th>
                     <th style="width: 300px;">제품</th>
                     <th style="width: 119.508px;">수량</th>
                     <th style="width: 119.508px;">단가</th>
                     <th style="width: 119.508px;">매입액</th>
                     <th style="width: 119.508px;">매출액</th>
                    </tr>
               </thead>
               <tbody class="table-border-bottom-0" id="tableBody" style="font-size: 12px;">
      			<!--전체거래처실적조회 -->
                <c:forEach var="customer" items="${customerSalesList}">    
					 <tr>
                     <td>${customer.month}</td>
                     <td>${customer.purDate}</td>
                  	 <td>${customer.custstyle == 0 ? '매입' : '매출'}</td>
                  	 <td>${customer.custcode }</td>
                     <td>${customer.company}</td>
                     <td>${customer.purCode}</td>
                     <td>${customer.itemName }</td>
                     <td>${customer.purQty}</td>
                     <td><fmt:formatNumber value="${customer.purPrice}" pattern="#,##0" /></td>
			        <!-- customer.custstyle에 따라 총 매입액(0) 또는 총 매출액(1) 표시 -->
			        <td><c:choose>
			            <c:when test="${customer.custstyle == 0}">
			                <fmt:formatNumber value="${customer.purQty * customer.purPrice}" pattern="#,##0" />
			            </c:when>
			            <c:otherwise>-</c:otherwise>
			        </c:choose></td>
			        <td><c:choose>
			            <c:when test="${customer.custstyle == 1}">
			                <fmt:formatNumber value="${customer.purQty * customer.purPrice}" pattern="#,##0" />
			            </c:when>
			            <c:otherwise>-</c:otherwise>
			        </c:choose></td>
                    </tr>

               </c:forEach>

                </tbody>
                <tfoot class="fixed-tfoot">			
					<c:set var="totalPurchaseAmount" value="0" />
					<c:set var="totalSalesAmount" value="0" />
					
					<c:forEach var="customer" items="${customerSalesList}">
					    <c:choose>
					        <c:when test="${customer.custstyle == 0}">
					            <c:set var="totalPurchaseAmount" value="${totalPurchaseAmount + (customer.purQty * customer.purPrice)}"/>
					        </c:when>
					        <c:when test="${customer.custstyle == 1}">
					            <c:set var="totalSalesAmount" value="${totalSalesAmount + (customer.purQty * customer.purPrice)}" />
					        </c:when>
					    </c:choose>
					</c:forEach>
	
				    	 <!-- 누계 행 추가 -->			
						<tr>
						<td colspan="6"></td>
						<th colspan="3">누          계</th>
					    <th><fmt:formatNumber value="${totalPurchaseAmount}" pattern="#,##0" /></th>
					    <th><fmt:formatNumber value="${totalSalesAmount}" pattern="#,##0" /></th>
					</tr>
        	  </tfoot>
              </table>
              </div>
              
   </div>           
</div>
</div>

</div>

</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>  
</html>