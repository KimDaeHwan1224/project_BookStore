<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>게시판 - 대기질 정보</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <!-- 외부 CSS -->
  <link rel="stylesheet" href="/css/boardManagement.css">
</head>
<body>
  <!-- 게시판 섹션 -->
  <section class="board-section">
    <div class="board-container">
      <div class="board-header">
		<!-- ✅ 게시판 제목 + 선택창을 같은 줄로 배치 -->
		<div style="display: inline-flex; align-items: center; gap: 8px;">
		  <h1 class="board-title" style="margin: 0;">게시판 관리</h1>
		</div>
	  </div>

	  <div class="board-table-wrapper">
	    <table class="board-table">
	      <thead>
	        <tr>
	          <th>번호</th>
	          <th>제목</th>
	          <th>작성자</th>
	          <th>작성일</th>
	          <th>조회수</th>
	        </tr>
	      </thead>
	      <tbody>
	        <c:choose>
	          <c:when test="${empty boardList}">
	            <tr>
	              <td colspan="5">등록된 게시물이 없습니다.</td>
	            </tr>
	          </c:when>
	          <c:otherwise>
	            <c:forEach var="board" items="${boardList}">
	              <tr>
	                <td>${board.boardNo}</td>
	                <td>
	                  <!-- 상세: 조회수 +1은 컨트롤러에서 처리 X (관리자용은 증가 안 함) -->
<!--	                   <a href="${pageContext.request.contextPath}/admin/board/detail?boardNo=${board.boardNo}">-->
					  <a href="javascript:void(0)"
						 onclick="loadPage('${pageContext.request.contextPath}/admin/board/detail?boardNo=${board.boardNo}')">
	                    <c:out value="${board.boardTitle}" />
	                  </a>
	                </td>
	                <td>${board.userNickname}</td>
	                <td>${board.formattedDate}</td>
	                <td>${board.boardHit}</td>
	              </tr>
	            </c:forEach>
	          </c:otherwise>
	        </c:choose>
	      </tbody>
	    </table>
	  </div>

	  <!-- 검색 영역 -->
	  <div class="board-search">
	    <form method="get" id="searchForm">
	      <select name="type" style="padding: 12px; border: 2px solid #eee; border-radius: 12px; font-size: 14px; margin-right: 8px;">
	        <option value="tc" ${type == 'tc' ? 'selected' : ''}>제목+내용</option>
	        <option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
	        <option value="content" ${type == 'content' ? 'selected' : ''}>내용</option>
	        <option value="writer" ${type == 'writer' ? 'selected' : ''}>작성자</option>
	      </select>
	      <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요" value="${fn:escapeXml(keyword)}" />
	      <input type="hidden" name="size" value="${size}" />
	      <button type="submit" class="search-btn">검색</button>
	    </form>
	  </div>

	  <!-- 페이지네이션 -->
        <div class="pagination">
          <c:if test="${startPage > 1}">
  			<a href="javascript:void(0)"
  	           onclick="loadPage('${pageContext.request.contextPath}/admin/boardManagement?page=${startPage-1}')">
  	            <
  	        </a>
          </c:if>

          <c:forEach var="i" begin="${startPage}" end="${endPage}">
  			<a href="javascript:void(0)"
  			   onclick="loadPage('${pageContext.request.contextPath}/admin/boardManagement?page=${i}')"
  			   class="${i == page ? 'active' : ''}">${i}
  			</a>
          </c:forEach>

          <c:if test="${endPage < pageCount}">
  			<a href="javascript:void(0)"
  			   onclick="loadPage('${pageContext.request.contextPath}/admin/boardManagement?page=${endPage+1}')">
  			    >
  			</a>
          </c:if>
        </div>
      </div>
    </section>
  <script>
  document.getElementById("searchForm").addEventListener("submit", function(e) {
      e.preventDefault(); // 기존 submit 막기

      const type = this.type.value;
      const keyword = this.keyword.value;

      const url = "${pageContext.request.contextPath}/admin/boardManagement"
                  + "?type=" + encodeURIComponent(type)
                  + "&keyword=" + encodeURIComponent(keyword);

      loadPage(url); // 비동기로 페이지 로드
  });
  </script>
</body>
</html>

