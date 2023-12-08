<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<h2>발주 상세</h2>
			</div>
			<div class="col-12">
				<table class="table">
					<tr>
						<td>날짜 </td><td>${pc.pur_date }</td>
						<td>회사명 </td><td>${pc.company }</td>
						<td>발주자 </td><td>${pc.appli_name }</td>
						<td>담당자 </td><td>${pc.mgr_name }</td>
					</tr>
				</table>
			</div>
			
		</div>
	</div>
</body>
</html>