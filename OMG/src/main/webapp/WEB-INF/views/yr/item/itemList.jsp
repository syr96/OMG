<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<style type="text/css">
	.linkText { color:#697a8d; }
</style>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<%@ include file="/WEB-INF/views/common/menu.jsp" %>
<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">제품 관리 /</span> 제품 조회</h4>
<!-- Basic Bootstrap Table -->
<div class="card">
  <h5 class="card-header">제품 목록</h5>
  <div class="table-responsive text-nowrap">
    <table class="table">
      <thead>
        <tr>
          <th>제품코드</th>
          <th>제품명</th>
          <th>카테고리</th>
        </tr>
      </thead>
      <tbody class="table-border-bottom-0">
        <tr>
          <td>0000</td>
          <td>
          	<a href="/item/detail"><strong class="linkText">모니터</strong></a>
          </td>
          <td>모니터</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<!--/ Basic Bootstrap Table -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>