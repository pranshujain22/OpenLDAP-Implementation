<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 10:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<%@ page import="search.LDAPSearch" %>
<html>
<head>
    <title>Users</title>
    <header>
        <h2 id="user-name-label">${cn}'s</h2>
        <h2 id="home-label"> Page</h2>
    </header>

    <link rel="stylesheet" href="css/users.css">
</head>
<body>


<ol class="menu">
    <li><a href="home.jsp">Home</a></li>
    <li><a id="usersMenu" href="users.jsp">Show Users</a></li>
    <li><a href="newentry.jsp">New Entry</a></li>
    <li><a href="updateUser.jsp">Update User</a></li>
    <li><a href="deleteUser.jsp">Delete User</a></li>
    <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
</ol>

<%
    String str = LDAPSearch.getUsers(authentication.getDirContext());
%>

<div class="users">
    <ul class="table">
        <%=str%>
    </ul>
</div>

</body>
</html>
