<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.moneybook.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    MoneyDAO dao = new MoneyDAO();
    dao.deleteMoney(id);

    response.sendRedirect("index.jsp");
%>