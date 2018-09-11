<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 3/8/18
  Time: 5:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<jsp:useBean id="logindetails" scope="application" class="authentication.LoginDetails"/>
<jsp:setProperty name="logindetails" property="*"/>

<html>
<head>
    <title>AuthenticateUser</title>
</head>
<body>
<%
    if (authentication.open(logindetails)) {
        session.setAttribute("session", "true");
        session.setAttribute("cn", logindetails.getDn().split(",")[0].split("=")[1].toUpperCase());
        response.sendRedirect("home.jsp");
    } else {
        request.setAttribute("loginResult", "Wrong DN or Password");
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(request, response);
    }
%>
</body>
</html>
