<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.Attribute" %>
<%@ page import="javax.naming.directory.Attributes" %>
<%@ page import="javax.naming.directory.DirContext" %>
<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 5/8/18
  Time: 10:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="logindetails" scope="application" class="authentication.LoginDetails"/>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
<header>
    <h2 id="user-name-label">${cn}'s</h2>
    <h2 id="home-label"> Home</h2>
</header>

<div align="centre">
    <%
        String label;
        String href;
        if (request.getParameter("internalAttr") != null) {
            label = "Hide internal attributes";
            href = "home.jsp";
        } else {
            label = "Show internal attributes";
            href = "home.jsp?internalAttr=true";
        }

        String entryResult = "";
        if (request.getParameter("entryResult") != null) {
            entryResult = request.getParameter("entryResult");
        }

    %>

    <ol class="menu">
        <li><a id="homeMenu" href="home.jsp">Home</a></li>
        <li><a href="users.jsp">Show Users</a></li>
        <li><a href="newentry.jsp">New Entry</a></li>
        <li><a href="updateUser.jsp">Update User</a></li>
        <li><a href="deleteUser.jsp">Delete User</a></li>
        <li><a href="<%=href%>"><%=label%>
        </a></li>
        <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
    </ol>

    <p align="center" id="entryResult" class="entryResult"><b><%=entryResult%>
    </b></p>

    <table align="center">
        <caption id="caption"><p><b>User Details</b></p></caption>
        <%
            try {
                DirContext dirContext = authentication.getDirContext();
                Attributes answer;
                if (request.getParameter("internalAttr") != null) {
                    answer = dirContext.getAttributes(logindetails.getDn(), new String[]{"*", "+"});
                } else {
                    answer = dirContext.getAttributes(logindetails.getDn());
                }

                for (NamingEnumeration ae = answer.getAll(); ae.hasMore(); ) {
                    Attribute attribute = (Attribute) ae.next();
                    if (attribute.getID().equals("userPassword"))
                        continue;
        %>
        <tr>
            <th><%=attribute.getID()%>
            </th>
            <% for (NamingEnumeration e = attribute.getAll(); e.hasMore(); ) {
            %>
            <td><%=e.next()%>
            </td>
            <% }
            %></tr>
        <% }
        } catch (Exception e) {
            out.print(e.getMessage());
        }
        %>
    </table>
</div>

</body>
</html>
