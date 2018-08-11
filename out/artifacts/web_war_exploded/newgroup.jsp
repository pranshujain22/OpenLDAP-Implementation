<%@ page import="javax.naming.NamingEnumeration" %>
<%@ page import="javax.naming.directory.*" %><%--
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
    <title>Create Group</title>
</head>
<body>

<%
    try {
        DirContext dirContext = authentication.getDirContext();

        String dn = request.getParameter("group-name").trim();
        if (request.getParameter("group-parent").contains(authentication.getDomain())) {
            dn = "cn=" + dn + "," + request.getParameter("group-parent");
        } else {
            dn = "cn=" + dn + "," + request.getParameter("group-parent") + "," + authentication.getDomain();
        }

        SearchControls controls = new SearchControls();
        controls.setSearchScope(SearchControls.SUBTREE_SCOPE);
        NamingEnumeration results = dirContext.search(authentication.getDomain(), "(objectClass=posixGroup)", controls);
        int gidNumber = 0;

        while (results.hasMore()) {
            SearchResult searchResult = (SearchResult) results.next();
            Attributes searchResultAttributes = searchResult.getAttributes();
//            System.out.println("Group Name "+ searchResultAttributes.get("cn").get(0));
            try {
                if (Integer.parseInt((String) searchResultAttributes.get("GidNumber").get(0)) > gidNumber)
                    gidNumber = Integer.parseInt((String) searchResultAttributes.get("GidNumber").get(0));
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        }
        gidNumber++;

        Attributes attributes = new BasicAttributes(true);
        Attribute objectClass = new BasicAttribute("objectClass");
        objectClass.add("posixGroup");
        objectClass.add("top");
        attributes.put(objectClass);
        attributes.put(new BasicAttribute("gidNumber", Integer.toString(gidNumber)));

        dirContext.createSubcontext(dn, attributes);

        response.sendRedirect("home.jsp?entryResult=Successfully created new Posix Group: " + dn);

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
