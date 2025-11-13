<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <!-- 공지사항 관리 섹션 -->
  <section class="board-section">
    <div class="board-container">

      <!-- 헤더 -->
      <div class="board-header" style="display: flex; justify-content: space-between; align-items: center;">
        <div style="display: flex; align-items: center; gap: 10px;">
          <h1 class="board-title" style="margin: 0;">공지사항 관리</h1>
        </div>

        <!-- 공지사항 글쓰기 버튼 -->
        <a href="/admin/notice/write" class="write-btn">공지 등록</a>
      </div>

      <!-- 공지 목록 테이블 -->
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
              <c:when test="${empty noticeList}">
                <tr>
                  <td colspan="5" class="empty-row">등록된 공지사항이 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="notice" items="${noticeList}">
                  <tr>
                    <td>${notice.noticeNo}</td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/notice/detail?noticeNo=${notice.noticeNo}">
                        <c:out value="${notice.noticeTitle}" />
                      </a>
                    </td>
                    <td>관리자</td>
                    <td>${notice.formattedDate}</td>
                    <td>${notice.noticeHit}</td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

      <!-- 검색 영역 -->
      <div class="board-search">
        <form method="get" action="${pageContext.request.contextPath}/noticeManagement" id="searchForm">
          <select name="type" style="padding: 12px; border: 2px solid #eee; border-radius: 12px; font-size: 14px; margin-right: 8px;">
            <option value="tc" ${type == 'tc' ? 'selected' : ''}>제목+내용</option>
            <option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${type == 'content' ? 'selected' : ''}>내용</option>
            <option value="writer" ${type == 'writer' ? 'selected' : ''}>작성자</option>
          </select>
          <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요" value="${param.keyword}">
          <button type="submit" class="search-btn">검색</button>
        </form>
      </div>

      <!-- 페이지네이션 -->
      <div class="pagination">
        <c:if test="${startPage > 1}">
          <a href="${pageContext.request.contextPath}/noticeManagement?page=${startPage-1}"><</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="${pageContext.request.contextPath}/noticeManagement?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${endPage < pageCount}">
          <a href="${pageContext.request.contextPath}/noticeManagement?page=${endPage+1}">></a>
        </c:if>
      </div>
    </div>
  </section>

</body>
</html>

