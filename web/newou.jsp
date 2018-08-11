<%@ page import="javax.naming.directory.*" %>
<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 7/8/18
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>Create OU</title>
</head>
<body>

<%
    try {
        String dn = request.getParameter("ou-name").trim();
        if (request.getParameter("ou-parent").contains(authentication.getDomain())) {
            dn = "ou=" + dn + "," + request.getParameter("ou-parent");
        } else {
            dn = "ou=" + dn + "," + request.getParameter("ou-parent") + "," + authentication.getDomain();
        }

        DirContext dirContext = authentication.getDirContext();
        Attributes attributes = new BasicAttributes(true);
        Attribute objectClass = new BasicAttribute("objectClass");
        objectClass.add("organizationalUnit");
        objectClass.add("top");
        attributes.put(objectClass);

        dirContext.createSubcontext(dn, attributes);

        response.sendRedirect("home.jsp?entryResult=Successfully created new Organizational Unit: " + dn);
    } catch (Exception e) {
        out.println(e.getMessage());
%>
<br><br>
<p align="center"><a href="newentry.jsp"><b>Go Back</b></a>.</p>
<%
    }
%>

</body>
</html>
