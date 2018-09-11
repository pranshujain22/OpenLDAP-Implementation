<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.*" %><%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 5:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>Delete Record</title>
    <header>
        <h2 id="user-name-label">${cn}'s</h2>
        <h2 id="home-label"> Page</h2>
    </header>

    <link rel="stylesheet" href="css/deleteUser.css">
</head>
<body>

<ol class="menu">
    <li><a href="home.jsp">Home</a></li>
    <li><a id="usersMenu" href="users.jsp">Show Users</a></li>
    <li><a href="newentry.jsp">New Entry</a></li>
    <li><a href="updateUser.jsp">Update User</a></li>
    <li><a id="deleteMenu" href="deleteUser.jsp">Delete User</a></li>
    <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
</ol>

<%--<p id="selectEntry" align="center"><b>Choose Entry</b></p>--%>

<div class="container" align="center">
    <form action="delete.jsp" style="max-width:500px;margin:auto">
        <hr>
        <h2>Choose Record</h2>
        <br>
        <select id="userDN" name="userDN" required>
            <%
                try {
                    Attributes match_attr = new BasicAttributes(true);
                    match_attr.put(new BasicAttribute("objectClass"));

                    String name = authentication.getDomain();
                    String[] attrIDs = {"cn"};
                    String filter = "(objectClass=*)";
                    SearchControls searchControls = new SearchControls();
                    searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
                    searchControls.setReturningAttributes(attrIDs);
                    NamingEnumeration answer = authentication.getDirContext().search(name, filter, searchControls);

                    while (answer.hasMore()) {
                        SearchResult searchResult = (SearchResult) answer.next();
                        if (searchResult.getName().contains("admin")) {
                            continue;
                        }
            %>
            <option><%=searchResult.getName()%>
            </option>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
        </select>
        <br>
        <br>
        <hr>

        <button type="submit" id="ou-btn" onclick="confirm()">Delete</button>
    </form>
</div>

<script>
    function confirm() {
        alert("are you sure want to delete " + document.getElementById("userDN").value);
    }
</script>

</body>
</html>
