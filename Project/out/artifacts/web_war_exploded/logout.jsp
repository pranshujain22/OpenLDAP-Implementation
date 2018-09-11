<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 7/8/18
  Time: 3:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>logout</title>
</head>
<body>
<%
    if (authentication.close()) {
        session.setAttribute("session", null);
%>
<p align="center" style="color: blue">You have been successfully logged out</p>
<jsp:include page="index.jsp"/>
<%
    }
%>
</body>
</html>
