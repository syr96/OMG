<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 조회</title>
<script type="text/javascript">
	// msg 값이 존재하면 alert 띄우기
	var msg = "${msg}";
	if(msg.length > 0)	alert(msg);

	// 필터 검색
	function filter() {
		var cate_md = $('#cate_md').val();
		var deleted = $('#deleted').val();
		
		location.href = "/item/list?cate_md="+cate_md + "&deleted=" + deleted;	
	}
	
	// 제품 상세 정보
	function showItemDetail(p_index) {
		$.ajax(
				{
					url: "/item/detail?code=" + p_index,
					dataType: "html",
					success: function(data) {
						$("#itemDetail").html(data);
					}
			}
		)
	};	
</script>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<%@ include file="/WEB-INF/views/common/menu.jsp" %>
	<div class="d-flex justify-content-between align-items-center">
		<h4 class="fw-bold py-3 mb-4">
			<span class="text-muted fw-light">제품 관리 / </span>
			<a href="/item/list" class="linkText">제품 조회</a>
		</h4>
		<form class="d-flex" onsubmit="return false">
	      <input class="form-control me-2" type="search" placeholder="제품코드 / 제품명 / 거래처명 / 거래처코드" />
	      <button class="btn btn-outline-primary" type="submit">검색</button>
	    </form>
	</div>
	<!-- 제품 조회 -->
	<div class="card">
	  <div class="card overflow-hidden row" style="height: 700px">
	  
	  	<!-- 제품 리스트 -->
	  	<div class="p-0 card-body table-responsive text-nowrap tableFixed col-4" id="both-scrollbars-example">
		    <table class="table table-hover fixedHeader">
		      <thead>
		        <tr class="table-primary">
		          <th class="stiky">제품코드</th>
		          <th class="stiky">제품명</th>
		          <th class="stiky">
		          	<select class="form-select" id="cate_md" onchange="filter()">
	          			<c:forEach items="${cm }" var="cm">
			          		<option value="${cm.ct_md }" <c:if test="${cate_md eq cm.ct_md }"> selected = "selected"</c:if>>${cm.com_cn }</option>
	          			</c:forEach>
		          	</select>
		          </th>
		          <th class="stiky">
		          	<select class="form-select" id="deleted" onchange="filter()">
		          		<option value="100" <c:if test="${deleted eq '100' }"> selected = "selected"</c:if>>판매여부</option>
		          		<option value="0"	<c:if test="${deleted eq '0' }">   selected = "selected"</c:if>>정상</option>
		          		<option value="1"	<c:if test="${deleted eq '1' }">   selected = "selected"</c:if>>판매종료</option>
		          	</select>		          	
		          </th>
		        </tr>
		      </thead>
		      <tbody class="table-border-bottom-0">
		      	<c:forEach items="${itemList }" var="itemList">
			        <tr>
			          <td class="text-center">
			          	<a onclick="showItemDetail(${itemList.code })">${itemList.code }</a>
			          </td>
			          <td>
			          	<a onclick="showItemDetail(${itemList.code })"><strong>${itemList.name }</strong></a>
			          </td>
			          <td class="text-center">
			          	<a onclick="showItemDetail(${itemList.code })">${itemList.com_cn }</a>
			          </td>
			          <td class="text-center">
			          	<a onclick="showItemDetail(${itemList.code })">
				          <c:choose>
				          	<c:when test="${itemList.deleted == '0'}">
				          		<span class="badge bg-label-primary me-1">정상</span>
				          	</c:when>
				          	<c:otherwise>
				          		<span class="badge bg-label-warning me-1">판매종료</span>
				          	</c:otherwise>
				          </c:choose>
			          	</a>
			          </td>
			        </tr>
		      	</c:forEach>
		      </tbody>
		    </table>
	    </div>
	    <!-- / 제품 리스트 -->
	    
	    <!-- 제품 상세정보 -->
	    <div id="itemDetail" class="card-body table-responsive text-nowrap col-8">
	    </div>
	    <!-- / 제품 상세정보 -->
	    
	  </div>
	</div>
	<!--/ 제품 조회 -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>