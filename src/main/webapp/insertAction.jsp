<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.moneybook.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String type = request.getParameter("type");
    String category = request.getParameter("category");
    int amount = Integer.parseInt(request.getParameter("amount"));
    String memo = request.getParameter("memo");
    String regDate = request.getParameter("regDate");

    MoneyDTO dto = new MoneyDTO();
    dto.setType(type);
    dto.setCategory(category);
    dto.setAmount(amount);
    dto.setMemo(memo);
    dto.setRegDate(regDate);

    MoneyDAO dao = new MoneyDAO();
    dao.insertMoney(dto);

    response.sendRedirect("index.jsp");
%>