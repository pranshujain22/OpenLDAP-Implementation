<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
    if (session.getAttribute("session") != null) {
        response.sendRedirect("home.jsp");
    }

    String loginResult = "";
    if (request.getAttribute("loginResult") != null) {
        loginResult = (String) request.getAttribute("loginResult");
    }
%>

<script>
    function clearLabel() {
        document.getElementById("loginResult").innerText = "";
    }
</script>

<form action="authenticate.jsp" method="post">
    <div class="img">
        <img src="img/man.svg" alt="Avatar" class="avatar">
    </div>

    <div class="loginForm">
        <p align="center" id="loginResult" class="result"><b><%=loginResult%>
        </b></p>

        <label for="dn"><b>Entry DN</b></label>
        <input type="text" placeholder="Entry DN" id="dn" name="dn" onclick="clearLabel()" required>

        <label for="secret"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" id="secret" name="secret" onclick="clearLabel()" required>

        <br><br>
        <label>
            <input type="checkbox" name="secure"> Anonymous
        </label>

        <button type="submit">Login</button>
    </div>

</form>

</body>
</html>
