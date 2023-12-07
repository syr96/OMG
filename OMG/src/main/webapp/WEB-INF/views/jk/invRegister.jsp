<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 부트스트랩 CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

<!-- 제이쿼리 및 부트스트랩 JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<%@ include file="../common/header.jsp" %>
<body>
<%@ include file="../common/menu.jsp" %>
	<div class="container-xxl flex-grow-1 container-p-y">
       <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">재고관리 /</span> 기초재고/재고조정등록</h4>
		<div class="card mb-4">
			<h5 class="card-header">기초재고</h5>
				<div class="card-body">
					<div class="row">
						<div class="mb-3 col-md-6">
                        <label for="html5-date-input" class="col-md-2 col-form-label">기준년월</label>
                          <input class="form-control" type="month" value="2021-06-18" id="html5-date-input">
                        </div>
                         <div class="mb-3 col-md-6">
                         <label for="html5-date-input" class="col-md-2 col-form-label">구분</label>
                         <select id="invType" class="select2 form-select">
                              <option value="">전체</option>
                              <option value="Australia">기초</option>
                              <option value="Bangladesh">기말</option>
                         </select>
                         </div>
                      </div>
 					</div>

		<!-- 재고리스트 -->
 			<div class="card">
                <h5 class="card-header">재고리스트</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>번호</th>
                        <th>품번</th>
                        <th>품목</th>
                        <th>품명</th>
                        <th>수량</th>
                        <th>조정수량</th>
                        <th>등록일</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                      <tr>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>Angular Project</strong></td>
                        <td>Albert Cook</td>
                        <td>
                          <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
                            <li data-bs-toggle="tooltip" data-popup="tooltip-custom" data-bs-placement="top" class="avatar avatar-xs pull-up" title="" data-bs-original-title="Lilian Fuller">
                              <img src="../assets/img/avatars/5.png" alt="Avatar" class="rounded-circle">
                            </li>
                            <li data-bs-toggle="tooltip" data-popup="tooltip-custom" data-bs-placement="top" class="avatar avatar-xs pull-up" title="" data-bs-original-title="Sophia Wilkerson">
                              <img src="../assets/img/avatars/6.png" alt="Avatar" class="rounded-circle">
                            </li>
                            <li data-bs-toggle="tooltip" data-popup="tooltip-custom" data-bs-placement="top" class="avatar avatar-xs pull-up" title="" data-bs-original-title="Christina Parker">
                              <img src="../assets/img/avatars/7.png" alt="Avatar" class="rounded-circle">
                            </li>
                          </ul>
                        </td>
                        <td><span class="badge bg-label-primary me-1">Active</span></td>
                        <td>
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="javascript:void(0);"><i class="bx bx-edit-alt me-1"></i> Edit</a>
                              <a class="dropdown-item" href="javascript:void(0);"><i class="bx bx-trash me-1"></i> Delete</a>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
 			</div>
 			
 			<!-- 재고리스트 -->
 		
        		 <div class="demo-inline-spacing mt-3">
                        <div class="list-group list-group-horizontal-md text-md-center">
                          <a class="list-group-item list-group-item-action active" id="home-list-item" data-bs-toggle="list" href="#horizontal-home">기초재고등록</a>
                          <a class="list-group-item list-group-item-action" id="profile-list-item" data-bs-toggle="list" href="#horizontal-profile">기초재고조정</a>
                          <a class="list-group-item list-group-item-action" id="messages-list-item" data-bs-toggle="list" href="#horizontal-messages">입고조정</a>
                          <a class="list-group-item list-group-item-action " id="settings-list-item" data-bs-toggle="list" href="#horizontal-settings">출고조정</a>
                        </div>
                        <div class="tab-content px-0 mt-0">
                          <div class="tab-pane fade  active show" id="horizontal-home">
		 				기초재고등록폼
		 				 <div class="card-body">
							<div class="row">
								<div class="mb-3 col-md-6">
		                        <label for="html5-date-input" class="col-md-2 col-form-label">기준년월</label>
		                          <input class="form-control" type="month" value="2021-06-18" id="html5-date-input">
		                        </div>
		                         <div class="mb-3 col-md-6">
		                         <label for="html5-date-input" class="col-md-2 col-form-label">구분</label>
		                         <select id="invType" class="select2 form-select">
		                              <option value="">전체</option>
		                              <option value="Australia">기초</option>
		                              <option value="Bangladesh">기말</option>
		                         </select>
		                         </div>
		                      </div>
		 					</div>                            	
                          </div>
                          <div class="tab-pane fade" id="horizontal-profile">
                      			기초재고조정폼
                    
                  
                          </div>
                          <div class="tab-pane fade" id="horizontal-messages">
                          		입고조정폼
                          </div>
                          <div class="tab-pane fade" id="horizontal-settings">
                            	출고조정폼
                          </div>
                        </div>
                      </div>
					</div>
              


</body>
<%@ include file="../common/footer.jsp" %>
</html>