<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, com.moneybook.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String month = request.getParameter("month"); // 예: "2026-11" 또는 null

    MoneyDAO dao = new MoneyDAO();
    List<MoneyDTO> list = dao.getMoneyList(month);
    int totalIncome = dao.getTotalByType("수입", month);
    int totalExpense = dao.getTotalByType("지출", month);
    int balance = totalIncome - totalExpense;

    DecimalFormat df = new DecimalFormat("#,###");
    String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나의 미니 가계부</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background: #f4f6f9; margin: 0; padding: 30px; color: #333; }
    .container { max-width: 850px; margin: 0 auto; background: #fff; padding: 25px 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
    h1 { margin-top: 0; font-size: 24px; color: #222; border-bottom: 2px solid #333; padding-bottom: 10px; }
    .summary { display: flex; gap: 15px; margin: 20px 0; }
    .card { flex: 1; padding: 15px; border-radius: 8px; background: #f8f9fa; border: 1px solid #e1e4e8; text-align: center; }
    .card h3 { margin: 0 0 8px; font-size: 14px; color: #666; }
    .card p { margin: 0; font-size: 20px; font-weight: bold; }
    .income { color: #1a73e8; }
    .expense { color: #d93025; }
    .form-box { background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 10px; align-items: center; }
    select, input[type="text"], input[type="number"], input[type="date"], input[type="month"] {
        padding: 8px 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px;
    }
    button { padding: 8px 16px; background: #222; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
    button:hover { background: #444; }
    .filter-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { padding: 12px 10px; border-bottom: 1px solid #eee; text-align: center; font-size: 14px; }
    th { background: #f1f3f5; font-weight: bold; }
    .btn-del { background: #e03131; padding: 4px 10px; font-size: 12px; }
    .btn-del:hover { background: #c92a2a; }
</style>
</head>
<body>
<div class="container">
    <h1>📒 나의 미니 가계부</h1>

    <!-- 1. 상단 합계 요약 카드 -->
    <div class="summary">
        <div class="card">
            <h3>총 수입</h3>
            <p class="income">+<%= df.format(totalIncome) %>원</p>
        </div>
        <div class="card">
            <h3>총 지출</h3>
            <p class="expense">-<%= df.format(totalExpense) %>원</p>
        </div>
        <div class="card">
            <h3>잔액</h3>
            <p><%= df.format(balance) %>원</p>
        </div>
    </div>

    <!-- 2. 내역 입력 폼 -->
    <form action="insertAction.jsp" method="post" class="form-box">
        <select name="type" required>
            <option value="지출">지출</option>
            <option value="수입">수입</option>
        </select>
        <select name="category" required>
            <option value="식비">식비</option>
            <option value="고정지출">고정지출</option>
            <option value="교통비">교통비</option>
            <option value="생활/쇼핑">생활/쇼핑</option>
            <option value="급여">급여</option>
            <option value="기타">기타</option>
        </select>
        <input type="number" name="amount" placeholder="금액 (원)" required min="1" style="width: 120px;">
        <input type="text" name="memo" placeholder="내용 메모 (예: 점심 식사)" style="flex: 1; min-width: 150px;">
        <input type="date" name="regDate" value="<%= today %>" required>
        <button type="submit">등록</button>
    </form>

    <!-- 3. 월별 필터링 조회 -->
    <div class="filter-bar">
        <strong>내역 목록 (<%= (month != null && !month.isEmpty()) ? month + " 기준" : "전체 기간" %> / 총 <%= list.size() %>건)</strong>
        <form action="index.jsp" method="get" style="display: flex; gap: 6px; align-items: center;">
            <input type="month" name="month" value="<%= (month != null) ? month : "" %>">
            <button type="submit">조회</button>
            <a href="index.jsp" style="font-size: 13px; color: #555; text-decoration: none; margin-left: 4px;">전체보기</a>
        </form>
    </div>

    <!-- 4. 가계부 내역 테이블 -->
    <table>
        <thead>
            <tr>
                <th>날짜</th>
                <th>구분</th>
                <th>카테고리</th>
                <th>내용</th>
                <th>금액</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
        <% if (list.isEmpty()) { %>
            <tr>
                <td colspan="6" style="padding: 30px; color: #888;">등록된 가계부 내역이 없습니다.</td>
            </tr>
        <% } else {
            for (MoneyDTO dto : list) {
                boolean isIncome = "수입".equals(dto.getType());
        %>
            <tr>
                <td><%= dto.getRegDate() %></td>
                <td><span class="<%= isIncome ? "income" : "expense" %>"><%= dto.getType() %></span></td>
                <td><%= dto.getCategory() %></td>
                <td style="text-align: left;"><%= dto.getMemo() != null ? dto.getMemo() : "" %></td>
                <td class="<%= isIncome ? "income" : "expense" %>" style="font-weight: bold;">
                    <%= isIncome ? "+" : "-" %><%= df.format(dto.getAmount()) %>원
                </td>
                <td>
                    <a href="deleteAction.jsp?id=<%= dto.getId() %>" onclick="return confirm('정말 삭제하시겠습니까?');">
                        <button type="button" class="btn-del">삭제</button>
                    </a>
                </td>
            </tr>
        <%  }
           } %>
        </tbody>
    </table>
</div>
</body>
</html>