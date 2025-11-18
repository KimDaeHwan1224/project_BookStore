<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="book-edit-wrapper">

    <!-- 카드 박스 -->
    <div class="book-edit-card">

        <!-- 왼쪽: 입력 폼 -->
        <div class="book-edit-left">
            <h2 class="section-title">도서 등록</h2>

            <form id="bookAddForm">

                <label class="label">제목</label>
                <input type="text" name="book_title" class="input" required>

                <label class="label">저자</label>
                <input type="text" name="book_writer" class="input" required>

                <label class="label">출판사</label>
                <input type="text" name="book_pub" class="input">

                <label class="label">출간일</label>
                <input type="date" name="book_date" class="input">

                <label class="label">장르</label>
                <select name="genre_id" class="input">
                    <c:forEach var="g" items="${genres}">
                        <option value="${g.genre_id}">${g.genre_name}</option>
                    </c:forEach>
                </select>

                <label class="label">가격</label>
                <input type="number" name="book_price" class="input">

                <label class="label">재고</label>
                <input type="number" name="book_count" class="input">

                <label class="label">ISBN</label>
                <input type="text" name="book_isbn" class="input">

                <label class="label">설명</label>
                <textarea name="book_comm" rows="3" class="input"></textarea>

                <label class="label">이미지 URL</label>
                <input type="text" name="book_image_path" class="input" 
                       oninput="previewAddImage()">

                <div class="btn-area">
                    <button type="button" class="btn-save" onclick="saveBookAdd()">등록</button>
                    <button type="button" class="btn-cancel" onclick="loadPage('/admin/book/list')">취소</button>
                </div>
            </form>
        </div>

        <!-- 오른쪽: 이미지 미리보기 -->
        <div class="book-edit-right">
            <img id="addPreview" class="preview-img"
                 src="https://via.placeholder.com/280x400?text=Book+Cover"
                 alt="preview">
        </div>

    </div>
</div>


<!-- 스타일 (수정 화면과 동일하게) -->
<style>
.book-edit-wrapper {
    padding: 20px;
}

.book-edit-card {
    background: white;
    border-radius: 12px;
    padding: 30px;
    display: flex;
    gap: 60px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}

.book-edit-left {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.section-title {
    font-size: 22px;
    margin-bottom: 10px;
    font-weight: bold;
    color: #5a4633;
}

.label {
    font-weight: 600;
    margin-top: 5px;
}

.input {
    padding: 10px;
    border: 1px solid #d7ccc8;
    border-radius: 6px;
    width: 100%;
}

.btn-area {
    margin-top: 15px;
    display: flex;
    gap: 10px;
}

.btn-save {
    background: #8d6e63;
    color: white;
    border: 0;
    padding: 10px 20px;
    border-radius: 6px;
}

.btn-cancel {
    background: #d7ccc8;
    border: 0;
    padding: 10px 20px;
    border-radius: 6px;
}

.book-edit-right {
    width: 300px;
    display: flex;
    justify-content: center;
}

.preview-img {
    width: 260px;
    height: auto;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}
</style>


<!-- JS (AJAX 등록 + 이미지 미리보기) -->
<script>
function previewAddImage() {
    const url = document.querySelector("input[name='book_image_path']").value;
    document.getElementById("addPreview").src = url || "https://via.placeholder.com/280x400?text=Book+Cover";
}

function saveBookAdd() {

    const form = document.getElementById("bookAddForm");

    const bookData = {
        book_title: form.book_title.value,
        book_writer: form.book_writer.value,
        book_pub: form.book_pub.value,
        book_date: form.book_date.value,
        genre_id: form.genre_id.value,
        book_price: form.book_price.value,
        book_count: form.book_count.value,
        book_comm: form.book_comm.value,
        book_isbn: form.book_isbn.value,
        book_image_path: form.book_image_path.value
    };

    fetch("/admin/book/add", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(bookData)
    })
    .then(res => res.text())
    .then(result => {
        alert("도서가 등록되었습니다.");
        loadPage('/admin/book/list');
    })
    .catch(err => {
        console.error(err);
        alert("등록 중 오류 발생");
    });
}
</script>
