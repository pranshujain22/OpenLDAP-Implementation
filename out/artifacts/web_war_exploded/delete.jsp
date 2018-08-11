<%@ page import="javax.naming.directory.DirContext" %><%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 5:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>

<html>
<head>
    <title>delete</title>
</head>
<body>

<%
    try {
        DirContext dirContext = authentication.getDirContext();
        dirContext.destroySubcontext(request.getParameter("userDN") + ",dc=jarvis,dc=com");

        response.sendRedirect("home.jsp?entryResult=Successfully deleted : " + request.getParameter("userDN"));

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>

</body>
</html>
