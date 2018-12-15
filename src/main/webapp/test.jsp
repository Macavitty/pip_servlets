<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>test</title>
</head>

<body>

<%int i = 1; %>
<%! int i = 0;%>
<% { i++; }%>
<%!{ i++; }%>
<%= i %>

</body>
</html>
