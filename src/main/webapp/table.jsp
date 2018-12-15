<%@ page import="beans.PointRow" %>
<%@ page import="beans.PointsBean" %>
<%@ page import="java.util.List" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="results" class="beans.PointsBean" scope="session">
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
    <title>Result</title>
    <meta charset="utf-8">
    <style>
        <%@include file='style.css' %>
    </style>
</head>
<body>
<div id="table_container">

    <header class="block">
    <span id="names">
            <h3>Лабораторная работа № 2<br/>
                Вариант 18131</h3><br/>
		Выполнили: Баталов Е. В. и Прилуцкая Т. И. <br/>
		Группа: P3201 <br/>

		</span>
    </header>
    <div id="h_table_area">
        <table id="history_table" align="center">
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th class="bool_result">Попадание в область</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <td><%= request.getParameter("x_input")%></td>
            <td><%= request.getParameter("y_input")%></td>
            <td><%= request.getParameter("r_input")%></td>
            <td>
                <%
                    if ((Boolean)request.getAttribute("isInputCorrect")) {
                        if ((Boolean) request.getAttribute("result")) {
                            out.println("да");
                        } else
                            out.println("нет");

                    } else
                        out.println("ой, кто-то сломал лабу");
                %>
            </td>
            </tbody>
        </table>
    </div>
    <form action="controller">
        <button id="back-page-button" type="submit">НАЗАД</button>
    </form>
</div>
</body>
</html>
