<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.Attribute" %>
<%@ page import="javax.naming.directory.Attributes" %>
<%@ page import="javax.naming.directory.DirContext" %>
<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 1:16 PM
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
    <h2 id="user-name-label"><%=request.getParameter("user")%> 's</h2>
    <h2 id="home-label"> Home</h2>
</header>

<div align="centre">
    <%
        String label;
        String href;
        if (request.getParameter("internalAttr") != null) {
            label = "Hide internal attributes";
            href = "userhome.jsp?user=" + request.getParameter("user");
        } else {
            label = "Show internal attributes";
            href = "userhome.jsp?internalAttr=true&user=" + request.getParameter("user");
        }
    %>

    <ol class="menu">
        <li><a href="home.jsp">Home</a></li>
        <li><a style="background-color: #4CAF50" href="users.jsp">Show Users</a></li>
        <li><a href="newentry.jsp">New Entry</a></li>
        <li><a href="updateUser.jsp">Update User</a></li>
        <li><a href="deleteUser.jsp">Delete User</a></li>
        <li><a href="<%=href%>"><%=label%>
        </a></li>
        <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
    </ol>

    <table align="center">
        <caption id="caption"><p><b>User Details</b></p></caption>
        <%
            try {
                DirContext dirContext = authentication.getDirContext();
                Attributes answer;
                if (request.getParameter("internalAttr") != null) {
                    answer = dirContext.getAttributes(request.getParameter("user"), new String[]{"*", "+"});
                } else {
                    answer = dirContext.getAttributes(request.getParameter("user"));
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
