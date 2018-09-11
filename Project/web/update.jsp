<%@ page import="javax.naming.directory.BasicAttribute" %>
<%@ page import="javax.naming.directory.DirContext" %>
<%@ page import="javax.naming.directory.ModificationItem" %><%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 6:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>update</title>
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
        String oldDN = request.getParameter("userDN") + "," + authentication.getDomain();

        dirContext.rename(oldDN, uid);

        ModificationItem[] modificationItems = new ModificationItem[3];

        modificationItems[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("sn", sn));
        modificationItems[1] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("givenName", givenName));
        modificationItems[2] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("userPassword", userPassword));

        dirContext.modifyAttributes(uid, modificationItems);

        response.sendRedirect("home.jsp?entryResult=Successfully updated User Account: " + uid);

    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
</body>
</html>
