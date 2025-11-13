<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f5f6f8;
            margin: 0;
            padding: 0;
        }

        .title {
            font-size: 32px;
            font-weight: 700;
            margin: 50px 0 20px 8%;
        }

        .table-container {
            width: 85%;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        thead {
            background: #1f4f7b;
            color: white;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        .btn-edit {
            padding: 6px 16px;
            background: #1f4f7b;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-delete {
            padding: 6px 16px;
            background: #cf3b3b;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-edit:hover { opacity: .85; }
        .btn-delete:hover { opacity: .85; }

    </style>
</head>

<body>

    <div class="title">회원 관리</div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>로그인 타입</th>
                    <th>가입일</th>
                    <th>관리</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="m" items="${members}">
                    <tr>
						<td>${m.user_id}</td>
						<td>${m.user_name}</td>
						<td>${m.user_nickname}</td>
						<td>${m.user_email}</td>
						<td>${m.user_phone_num}</td>
						<td>${m.login_type}</td>
						<td>${m.reg_date}</td>



                        <td>
                            <button class="btn-edit"
                                onclick="loadPage('/admin/member/detail?user_id=${m.user_id}')">
                                수정
                            </button>

                            <button class="btn-delete"
                                onclick="if(confirm('삭제할까요?')) loadPage('/admin/member/delete?user_id=${m.user_id}')">
                                삭제
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
