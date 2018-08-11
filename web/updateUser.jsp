<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.*" %><%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 9/8/18
  Time: 5:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<html>
<head>
    <title>Update Record</title>
    <header>
        <h2 id="user-name-label">${cn}'s</h2>
        <h2 id="home-label"> Page</h2>
    </header>

    <link rel="stylesheet" href="css/updateUser.css">
</head>
<body>

<ol class="menu">
    <li><a href="home.jsp">Home</a></li>
    <li><a href="users.jsp">Show Users</a></li>
    <li><a href="newentry.jsp">New Entry</a></li>
    <li><a id="updateMenu" href="updateUser.jsp">Update User</a></li>
    <li><a href="deleteUser.jsp">Delete User</a></li>
    <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
</ol>

<%--<p id="selectEntry" align="center"><b>Choose Entry</b></p>--%>

<div class="container" align="center">
    <form id="form" action="update.jsp" style="max-width:500px;margin:auto">
        <hr>
        <h2>Choose Record</h2>
        <br>
        <select id="userDN" name="userDN" onclick="userSelected()" required>
            <%
                try {
                    Attributes match_attr = new BasicAttributes(true);
                    match_attr.put(new BasicAttribute("objectClass"));

                    String name = authentication.getDomain();
                    String[] attrIDs = {"cn"};
                    String filter = "(objectClass=inetorgperson)";
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

        <div class="container2" style="display: none" id="update-form" align="center">

            <label for="user-cn"><b>Common Name</b></label>
            <input id="user-cn" type="text" placeholder="Common Name" name="user-cn" required>

            <br>
            <label for="user-givenName"><b>First Name</b></label>
            <input id="user-givenName" type="text" placeholder="First Name" name="user-givenName" required>

            <br>
            <label for="user-sn"><b>Last Name</b></label>
            <input id="user-sn" type="text" placeholder="Last Name" name="user-sn" required>

            <label for="user-parent"><b>Parent</b></label>
            <select id="user-parent" name="user-parent" required>
                <%
                    try {
                        Attributes match_attr = new BasicAttributes(true);
                        match_attr.put(new BasicAttribute("objectClass"));

                        String name = authentication.getDomain();
                        String[] attrIDs = {"cn"};
                        String filter = "(objectClass=posixGroup)";
                        SearchControls searchControls = new SearchControls();
                        searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
                        searchControls.setReturningAttributes(attrIDs);
                        NamingEnumeration parent = authentication.getDirContext().search(name, filter, searchControls);
                        while (parent.hasMore()) {
                            SearchResult searchResult = (SearchResult) parent.next();
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
            <label for="user-userPassword"><b>Password</b></label>
            <input id="user-userPassword" type="password" placeholder="Password" name="user-userPassword"
                   onclick="clearLabel()" required>

            <br>
            <label for="user-re-userPassword"><b>Retype Password</b></label>
            <input id="user-re-userPassword" type="password" placeholder="Retype Password" name="user-re-userPassword"
                   onclick="clearLabel()" required>

            <p id="checkPassword" align="center"></p>

        </div>

        <hr>
        <button type="button" id="ou-btn" onclick="matchPassword()">Update</button>
    </form>
</div>

<script>
    function userSelected() {
        document.getElementById("update-form").style.display = "block";
    }

    function clearLabel() {
        document.getElementById("checkPassword").innerText = "";
    }

    function matchPassword() {
        if (document.getElementById("user-userPassword").value != document.getElementById("user-re-userPassword").value) {
            document.getElementById("checkPassword").innerText = "Password does not match";
            alert("Password does not match")
        } else {
            document.getElementById("form").submit();
        }
    }
</script>

</body>
</html>
