<%--
  Created by IntelliJ IDEA.
  User: jarvis
  Date: 7/8/18
  Time: 12:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="authentication" scope="application" class="authentication.AuthenticateUser"/>
<%@ page import="search.LDAPSearch" %>
<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.*" %>
<html>
<head>
    <title>New Entry</title>
    <header>
        <h2 id="user-name-label">${cn}'s</h2>
        <h2 id="home-label"> Page</h2>
    </header>

    <link rel="stylesheet" href="css/newentry.css">
</head>
<body>

<ol class="menu">
    <li><a href="home.jsp">Home</a></li>
    <li><a href="users.jsp">Show Users</a></li>
    <li><a id="newEntryMenu" href="newentry.jsp">New Entry</a></li>
    <li><a href="updateUser.jsp">Update User</a></li>
    <li><a href="deleteUser.jsp">Delete User</a></li>
    <li class="logout"><a href="logout.jsp"><b>Log Out</b></a></li>
</ol>

<p id="entryType" align="center"><b>Choose Entry Type</b></p>

<div align="center">
    <input id="ou" type="radio" name="type" onclick="showTable()"/>
    <label for="ou">Organisational Unit</label>
    <input id="group" type="radio" name="type" onclick="showTable()"/>
    <label for="group">Posix Group</label>
    <input id="user" type="radio" name="type" onclick="showTable()"/>
    <label for="user">User Account</label>
</div>

<script>
    function showTable() {
        if (document.getElementById("ou").checked) {
            document.getElementById("ou-form").style.display = "block";
            document.getElementById("group-form").style.display = "none";
            document.getElementById("user-form").style.display = "none";
        } else if (document.getElementById("group").checked) {
            document.getElementById("group-form").style.display = "block";
            document.getElementById("ou-form").style.display = "none";
            document.getElementById("user-form").style.display = "none";
        } else if (document.getElementById("user").checked) {
            document.getElementById("user-form").style.display = "block";
            document.getElementById("ou-form").style.display = "none";
            document.getElementById("group-form").style.display = "none";
        }
    }

</script>

<div class="container" style="display: none" id="ou-form" align="center">
    <form action="newou.jsp" style="max-width:500px;margin:auto">
        <h2>Organisational Unit</h2>

        <hr>
        <label for="ou-name"><b>Name</b></label>
        <input id="ou-name" type="text" placeholder="Name" name="ou-name" required>

        <label for="ou-parent"><b>Parent</b></label>
        <select id="ou-parent" name="ou-parent" required>
            <option><%=authentication.getDomain()%>
            </option>
            <%
                try {
                    NamingEnumeration answer = LDAPSearch.getAllUserNames(authentication.getDirContext());
                    while (answer.hasMore()) {
                        SearchResult searchResult = (SearchResult) answer.next();
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
        <hr>

        <button type="submit" id="ou-btn">Register</button>
    </form>
</div>

<div class="container" style="display: none" id="group-form" align="center">
    <form action="newgroup.jsp" style="max-width:500px;margin:auto">
        <h2>Posix Group</h2>

        <hr>
        <label for="group-name"><b>Name</b></label>
        <input id="group-name" type="text" placeholder="Name" name="group-name" required>

        <label for="group-parent"><b>Parent</b></label>
        <select id="group-parent" name="group-parent" required>
            <option><%=authentication.getDomain()%>
            </option>
            <%
                try {
                    NamingEnumeration answer = LDAPSearch.getAllUserNames(authentication.getDirContext());
                    while (answer.hasMore()) {
                        SearchResult searchResult = (SearchResult) answer.next();
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
        <hr>

        <button type="submit" id="group-btn">Register</button>
    </form>
</div>

<div class="container" style="display: none" id="user-form" align="center">
    <form action="newuser.jsp" style="max-width:500px;margin:auto">
        <h2>User Account</h2>

        <hr>

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

        <hr>

        <button type="submit" id="user-btn" onclick="matchPassword()">Register</button>
    </form>
</div>

<div>
    <p id="checkPassword" align="center"></p>
</div>

<script>
    function clearLabel() {
        document.getElementById("checkPassword").innerText = "";
    }

    function matchPassword() {
        if (document.getElementById("user-userPassword").value != document.getElementById("user-re-userPassword").value) {
            document.getElementById("checkPassword").innerText = "Password does not match";
            // alert("Password does not match")
        } else {
            window.location = "newuser.jsp";
        }
    }
</script>

<div>
    <br><br>
    <p align="center">Don't want to create new entry <a href="home.jsp"><b>Go Back</b></a>.</p>
</div>

</body>
</html>
