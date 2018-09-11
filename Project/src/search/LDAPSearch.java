package search;

import javax.naming.NamingEnumeration;
import javax.naming.directory.*;
import java.util.LinkedList;

public class LDAPSearch {
    private static String domain = "dc=jarvis,dc=com";
    private static DirContext dirContext;
    public static String getUsers(DirContext ctx){
        dirContext = ctx;
        return createList(domain);
    }

    private static String createList(String name){
        String str;
        str = "<li><a href=\"userhome.jsp?user=" + name + "\">" + name + "</a></li>";
        str += "<ul>";
        LinkedList<String> linkedList = getUserList(name);
        for (String x : linkedList) {
            str += createList(x + "," + name);
        }
        str += "</ul>";

        return str;
    }

    private static LinkedList<String> getUserList(String name){
        LinkedList<String> users = new LinkedList<String>();
        try {
            Attributes match_attr = new BasicAttributes(true);
            match_attr.put(new BasicAttribute("objectClass"));

            String[] attrIDs = {"cn"};
            String filter = "(objectClass=*)";
            SearchControls searchControls = new SearchControls();
            searchControls.setSearchScope(SearchControls.ONELEVEL_SCOPE);
            searchControls.setReturningAttributes(attrIDs);
            NamingEnumeration answer = dirContext.search(name, filter, searchControls);

            while (answer.hasMore()) {
                SearchResult sr = (SearchResult) answer.next();
                users.add(sr.getName());
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }

        return users;
    }

    public static NamingEnumeration getAllUserNames(DirContext dirContext){
        try {
            Attributes match_attr = new BasicAttributes(true);
            match_attr.put(new BasicAttribute("objectClass"));

            String name = domain;
            String[] attrIDs = {"cn"};
            String filter = "(objectClass=organizationalUnit)";
            SearchControls searchControls = new SearchControls();
            searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
            searchControls.setReturningAttributes(attrIDs);
            return dirContext.search(name, filter, searchControls);
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return null;
    }
}
