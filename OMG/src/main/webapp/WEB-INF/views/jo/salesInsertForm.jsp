<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="../common/header.jsp" %>
	<style>
		 #itemTable {
            border: 2px double black; /* 이중 실선 */
            width: 100%;
            border-collapse: collapse;
        }

        #itemTable thead tr {
            color: white;
            border-bottom: 2px solid black; /* 굵은 실선 */
        }

        #itemTable tbody tr {
            border-bottom: 1px solid black; /* 실선 */
        }

        #itemTable th, #itemTable td {
            border-right: 1px solid black; /* 실선 */
            padding: 8px;
            text-align: center;
        }
        
        .button-group {
       		 margin-top: -10px; /* 버튼을 위로 올리기 위해 음수 값으로 설정 */
    	}
    	
	</style>
	<script>
	// '제품추가'시 추가 행 생성
	function addRow() {
	      var table = document.getElementById("itemTable").getElementsByTagName('tbody')[0];
	      var newRow = table.insertRow(table.rows.length);
	
	      var cell1 = newRow.insertCell(0);
	      var cell2 = newRow.insertCell(1);
	      var cell3 = newRow.insertCell(2);
	      var cell4 = newRow.insertCell(3);
	      var cell5 = newRow.insertCell(4);
	      var cell6 = newRow.insertCell(5);
	      	      
	      cell1.innerHTML = table.rows.length; // No.
	      cell2.innerHTML = '<input type="text" name="code">';
	      cell3.innerHTML = '<select name="name" onchange="updateCodeAndPrice(this)">' +
	      					'<option>선택</option>' +
	      					'<c:forEach var="listProduct" items="${listProduct}">' +
	      					'<option data-code="${listProduct.code}" data-price="${listProduct.output_price}">${listProduct.name}</option>' +
							'</c:forEach>' +	
							'</select>'
	      cell4.innerHTML = '<input type="text" name="qty" oninput="calculateTotalPrice(this)">';
	      cell5.innerHTML = '<input type="text" name="price">';
	      cell6.innerHTML = '<input type="text" name="total_price">';
	 }
	
	// 새로 추가된 행의 데이터 수집
    var rowData = {
        code: '',
        name: '',
        qty: '',
        price: '',
        total_price: ''
    };
	
    // 추가된 행의 데이터를 배열에 추가
    rowDataArray.push(rowData);

	// 드롭다운 선택 시 "code"와 "price"를 업데이트
	function updateCodeAndPrice(selectElement) {
	    var selectedOption = selectElement.options[selectElement.selectedIndex];
	    var row = selectElement.parentNode.parentNode;
	    var codeInput = row.cells[1].getElementsByTagName('input')[0];
	    var priceInput = row.cells[4].getElementsByTagName('input')[0];

	    codeInput.value = selectedOption.getAttribute('data-code');
	    priceInput.value = selectedOption.getAttribute('data-price');
	}
	
	// 수량 입력 시 총 금액 계산
	function calculateTotalPrice(inputElement) {
	    var row = inputElement.parentNode.parentNode;
	    var qty = row.cells[3].getElementsByTagName('input')[0].value;
	    var price = row.cells[4].getElementsByTagName('input')[0].value;
	    var totalPriceInput = row.cells[5].getElementsByTagName('input')[0];

	    var total_price = parseInt(qty) * parseInt(price);
	    totalPriceInput.value = isNaN(total_price) ? '' : '￦' + total_price.toFixed();
	}
	
	// '저장' 버튼 클릭 시 데이터 전송
	function saveData() {
	    // 추가된 행의 데이터를 서버로 전송
	    // AJAX를 사용하여 서버로 데이터를 전송
	    var xhr = new XMLHttpRequest();
	    var url = "/sales/salesInsert"; // 서버의 컨트롤러 매핑 주소
	    xhr.open("POST", url, true);
	    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

	    // 배열을 JSON 문자열로 변환하여 전송
	    var data = JSON.stringify(rowDataArray);

	    xhr.onreadystatechange = function () {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            console.log(xhr.responseText);
	            // 서버로부터의 응답을 처리하는 코드 작성
	            // 예를 들어, 리다이렉트 등의 동작 수행
	        }
	    };

	    xhr.send(data);
	}
	
	</script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<main>
			<div>
		   		<h1>판매입력</h1>
			</div>
			
			<!-- Section1: Table -->
			<div>
				<div>
					<div>
					<form action="salesInsert" method="post">
						<div class="mb-3 ">
						  <label for="sales_date" class="form-label" style="font-size: 15px;">매출일자</label>
						  <input type="text" class="form-control" name="sales_date" id="sales_date" required="required" pattern="\d{2}/\d{2}/\d{2}" placeholder="23/MM/DD">
						</div>
						<div class="mb-3 ">
						  <label for="title" class="form-label" style="font-size: 15px;">제목</label>
						  <input type="text" class="form-control" name="title" id="title" required="required" placeholder="판매전표_2023YYMM_(주)XXX">
						</div>
						<div class="mb-3 ">
						  <label for="company" class="form-label" style="font-size: 15px;">거래처명</label>
						  <input type="hidden" name="custstyle" value="1">
						  <select class="form-select" aria-label="custcode" name="custcode" required="required">
							<c:forEach var="custCode" items="${listCustCode}">
								<option value="${custCode.custcode}">${custCode.company}</option>
							</c:forEach>
						  </select>
						</div>
						<div class="mb-3 ">
						  <label for="ref" class="form-label" style="font-size: 15px;">비고</label>
						  <textarea class="form-control" name="ref" id="ref" rows="5" ></textarea>
						</div>
																							
						<hr class="hr" />			
						
						<table id="itemTable" class="table table-md text-center p-3">
							<thead>
								<tr style="border: 2px solid black; background-color: #696cff; color: #fff;">
									<th scope="col">No.</th>
									<th scope="col">제품코드</th>
									<th scope="col">제품명</th>
									<th scope="col">수량</th>
									<th scope="col">가격</th>
									<th scope="col">총 금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td><input type="text" name="code"></td>
									<td>
										<select name="name" onchange="updateCodeAndPrice(this)">
											<option>선택</option>
											<c:forEach var="listProduct" items="${listProduct}">
												<option data-code="${listProduct.code}" data-price="${listProduct.output_price}">${listProduct.name}</option>
											</c:forEach>	
										</select>
									</td>
									<td><input type="text" name="qty" oninput="calculateTotalPrice(this)"></td>
									<td><input type="text" name="price"></td>
									<td><input type="text" name="total_price"></td>
								</tr>
							</tbody>
						 </table>
					
					<div class="button-group">
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="addRow()">제품추가</button>
						<input type=submit id="regist-btn" class="btn btn-primary btn-sm mb-1" value="저장">
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='salesInquiry'">리스트</button>
					</div>
						
						</form>
						</div>
					</div>
				</div>
				
			</main>
	 	 </div>
	  </div>				
<%@ include file="../common/footer.jsp" %>	
</body>
</html>