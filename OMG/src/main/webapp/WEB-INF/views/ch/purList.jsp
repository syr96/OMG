<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/menu.jsp" %>
</head>
<body>
	<div class="conatiner">
		<div class="row">
			<div class="col-12">
				<h2>발주 리스트</h2>
			</div>
			<div class="col-12">
				<table>
					<thead>
						<tr>
							<td>No.</td>
							<td>제목</td>
							<td>회사명</td>
							<td>발주일</td>
							<td>상품종류</td>
							<td>총수량</td>
							<td>총금액</td>
							<td>상태</td>
						</tr>
					</thead>
					<c:set var="num" value="1"></c:set>
					<tbody>
						<c:forEach items="#{purList }" var="purList">
							<tr>
								<td>${num }</td>
								<td>${purList.title }</td>
								<td>${purList.mem_name }</td>
							</tr>
							<c:set var="num" value="${num+1 }"></c:set>
						</c:forEach>
						
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
</body>
</html>