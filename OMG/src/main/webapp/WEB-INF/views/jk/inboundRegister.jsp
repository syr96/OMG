<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입고등록</title>
</head>
<script>
$(document).ready(function() {
    // 페이지 로드 시 초기 데이터 로딩
    fetchDataAndRenderList();

    // 기준년월과 구분이 변경될 때마다 데이터 다시 로딩
    $('#monthSelect').change(function() {
        fetchDataAndRenderList();
    });

    function fetchDataAndRenderList() {
        var selectedMonth = $('#monthSelect').val().replace('-', '');
        console.log('Selected Month:', selectedMonth);
   
        // Ajax 요청을 통해 서버에서 데이터를 가져옵니다.
        $.ajax({
            url: '/invPurList',
            method: 'GET',
            data: { month: selectedMonth},
            success: function(response) {
                console.log('Received data from server:', response);
                updateInventoryList(response);
            },
            error: function(error) {
                console.error('데이터를 불러오는 중 오류가 발생했습니다.', error);
            }
        });
    }

    function updateInventoryList(data) {
        var tbody = $('#purListTable tbody');
        tbody.empty(); // 테이블 초기화

        for (var i = 0; i < data.length; i++) {
            var regDate = new Date(data[i].reg_date);
            var formattedDate = regDate.toLocaleString('ko-KR', {
                year: 'numeric',
                month: 'numeric',
                day: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                second: 'numeric'
            });

            var row = '<tr>' +
                '<td style="width: 3px;">' + (i + 1) + '</td>' +
                '<td>' + data[i].ym + '</td>' +
                '<td>' + (data[i].inven === 0 ? '기초' : '기말') + '</td>' +
                '<td>' + data[i].code + '</td>' +
                '<td>' + data[i].name + '</td>' +
                '<td>' + data[i].cnt + '</td>' +
                '<td>' + '-' + '</td>' +
                '<td>' + data[i].mem_name + '</td>' +
                '<td>' + formattedDate + '</td>' + // 변경된 날짜 포맷 적용
                '</tr>';
            tbody.append(row);
        }
    }
</script>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/menu.jsp" %>

    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4">
            <span class="text-muted fw-light">재고관리 /</span>입고등록
        </h4>

        <!-- 재고리스트 -->
        <div class="demo-inline-spacing mt-3">
            <div class="list-group list-group-horizontal-md text-md-center">
                <a class="list-group-item list-group-item-action active" id="home-list-item" data-bs-toggle="list" href="#horizontal-home">입고등록</a>
                <a class="list-group-item list-group-item-action" id="messages-list-item" data-bs-toggle="list" href="#horizontal-messages">입고조정</a>
            </div>

            <div class="tab-content px-0 mt-0" style="padding-top: 0px;padding-bottom: 0px;margin-top: 1px;">
                <div class="tab-pane fade active show" id="horizontal-home">
                    <div class="card">
                  
                        <h5 class="card-header">발주서 선택</h5>
                          <div class="card-body">
                            <div class="row align-items-end" style="padding-left: 23px;">
                                <div class="mb-3 col-md-3">
                                    <label for="thtml5-date-input" class="col-md-2 col-form-label">날짜</label>
                                    <input class="form-control" type="date" id="srchDate" value="${srchDate }" pattern="YY/MM/DD">
                                </div>
                                <div class="mb-3 col-md-3">
                                    <label for="html5-date-input" class="col-md-2 col-form-label">업체명</label>
                                    
                                   <select id="srchCompany" class="select2 form-select">
										<option value="all" selected="selected">전체</option>
										<c:forEach items="${pur_custList }" var="pur_custList">
											<c:choose>
												<c:when test="${pur_custList.custcode == srchCompany }">
													<option value="${pur_custList.custcode }" selected="selected">${pur_custList.company }</option>
												</c:when>
												<c:otherwise>
													<option value="${pur_custList.custcode }">${pur_custList.company }</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
                                </div>
                                <div class="mb-3 col-md-3">
                                    <button class="btn btn-outline-primary" type="button" onclick="srch()">검색</button>
                                </div>
                            </div>
                            <h5 class="card-header">발주리스트</h5>
                            <div class="card-body">
                                <div class="table-responsive text-nowrap">
                                    <table class="table table-bordered" id="purListTable">
                                        <thead class="table-primary">
                                            <tr>
                                               	<td class="text-center">No.</td>
												<td class="text-center">제목</td>
												<td class="text-center">회사명</td>
												<td class="text-center">발주일</td>
												<td class="text-center">발주자</td>
												<td class="text-center">상품수</td>
												<td class="text-center">총수량</td>
												<td class="text-center">총금액</td>
												<td class="text-center">상태</td>
                                            </tr>
                                        </thead>
                                       	<c:set value="${totalPur }" var="num"/>
				    	<c:forEach items="${purList }" var="purList">
							<tr>
								<td class="text-center">${num }</td>
								<td class="text-start"><a href="/purDtail?pur_date=${purList.pur_date }&custcode=${purList.custcode }">${purList.title }</a></td>
								<td class="text-center">${purList.company }</td>
								<td class="text-center">${purList.pur_date }</td>
								<td class="text-center">${purList.appli_name}</td>
								<td class="text-center">${purList.totalType}</td>
								<td class="text-center">${purList.totalQty}개</td>
								<td class="text-center"><fmt:formatNumber value="${purList.totalPrice}" pattern="#,###"/>원</td>
								 <td class="text-center">
        <!-- pur_status가 0이면 "진행중" 출력 -->
        <c:if test="${purList.pur_status == 0}"><span class="badge bg-label-primary me-1">진행중</span></c:if>

        <!-- pur_status가 1이면 "입고" 버튼 생성 -->
        <c:if test="${purList.pur_status == 1}">
            <button class="btn btn-outline-primary" type="button" onclick="srch()">입고</button>
        </c:if>

        <!-- pur_status가 2이면 "입고완료" 출력 -->
        <c:if test="${purList.pur_status == 2}"><span class="badge bg-label-success me-1">입고완료</span></c:if>
    </td>

								
							</tr>
								<c:set var="num" value="${num-1 }"></c:set>
						</c:forEach>
				    </tbody>
                                         <tbody class="table-border-bottom-0">
                        				 </tbody>
                                    </table>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="horizontal-profile">
                    입출고관리폼
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
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="card mb-4">
            <h5 class="card-header">입고내역</h5>
            <div class="card-body">
                <div class="row">
                    <div class="mb-3 col-md-6">
                        <label for="html5-date-input" class="col-md-2 col-form-label">기준년월</label>
                        <input class="form-control" type="month" value="2021-06-18" id="monthSelect" name="monthIOData">
                    </div>
                    <div class="mb-3 col-md-6">
                        <label for="html5-date-input" class="col-md-2 col-form-label">구분</label>
                        <select id="IO_Type" class="select2 form-select">
                            <option value="ALL">전체</option>
                            <option value="INBOUND">입고</option>
                            <option value="OUTBOUND">출고</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- 재고리스트 -->
            <div class="card">
                <h5 class="card-header">입고내역</h5>
                <div class="card-body">
                    <div class="table-responsive text-nowrap">
                        <table class="table table-bordered" id="inventoryTable">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>년월</th>
                                    <th>구분</th>
                                    <th>품번</th>
                                    <th>품명</th>
                                    <th>수량</th>
                                    <th>담당자</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
    <script type="text/javascript">

</script>
</body>
</html>
