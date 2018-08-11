<%@ page import="javax.naming.directory.*" %><%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 8/8/18
  Time: 11:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>Create USer</title>
</head>
<body>

<%
    try {
        DirContext dirContext = authentication.getDirContext();

        String uid = request.getParameter("user-cn").trim();
        uid = "uid=" + uid + "," + request.getParameter("user-parent") + "," + authentication.getDomain();
        String givenName = request.getParameter("user-givenName");
        String sn = request.getParameter("user-sn");
        String userPassword = request.getParameter("user-userPassword");

        Attributes attributes = new BasicAttributes(true);
        Attribute objectClass = new BasicAttribute("objectClass");
        objectClass.add("top");
        objectClass.add("person");
        objectClass.add("organizationalPerson");
        objectClass.add("inetorgperson");

        attributes.put(objectClass);
        attributes.put(new BasicAttribute("uid", uid));
        attributes.put(new BasicAttribute("cn", uid));
        attributes.put(new BasicAttribute("sn", sn));
        attributes.put(new BasicAttribute("givenNAme", givenName));
        attributes.put(new BasicAttribute("userPassword", userPassword));

        dirContext.createSubcontext(uid, attributes);

        response.sendRedirect("home.jsp?entryResult=Successfully created new User Account: " + uid);

    }catch (Exception e){
        out.println(e.getMessage());
    }
%>

</body>
</html>
