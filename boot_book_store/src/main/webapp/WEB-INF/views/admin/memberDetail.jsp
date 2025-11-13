<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f5f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 20px;
            font-size: 28px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .btn-wrap {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
        }

        .btn-save { background: #1f4f7b; color: #fff; }
        .btn-cancel { background: #aaa; color: #fff; }

        .btn-save:hover, .btn-cancel:hover {
            opacity: .85;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>회원 상세 정보</h2>

        <form action="/admin/member/edit" method="post">

            <label>아이디</label>
            <input type="text" name="user_id" value="${member.USER_ID}" readonly>

            <label>이름</label>
            <input type="text" value="${member.USER_NAME}" readonly>

            <label>닉네임</label>
            <input type="text" name="user_nickname" value="${member.USER_NICKNAME}">

            <label>이메일</label>
            <input type="text" name="user_email" value="${member.USER_EMAIL}">

            <label>전화번호</label>
            <input type="text" name="user_phone_num" value="${member.USER_PHONE_NUM}">

            <label>주소</label>
            <input type="text" name="user_address" value="${member.USER_ADDRESS}">

            <label>상세주소</label>
            <input type="text" name="user_detail_address" value="${member.USER_DETAIL_ADDRESS}">

            <div class="btn-wrap">
                <button class="btn btn-save" type="submit">저장</button>
                <button class="btn btn-cancel" type="button" onclick="loadPage('/admin/member/adminlist')">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
