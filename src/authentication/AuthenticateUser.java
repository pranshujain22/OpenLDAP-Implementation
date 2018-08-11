package authentication;

import javax.naming.Context;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import java.util.Hashtable;

public class AuthenticateUser {
    private final String url = "ldap://localhost:389";
    private DirContext dirContext;
    private static String domain = "dc=jarvis,dc=com";

    public boolean open(LoginDetails loginDetails) {

        String security;
        if (loginDetails.isSecure()){
            security = "none";
        }else {
            security = "simple";
        }
        Hashtable env = new Hashtable();

        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, url);
        env.put(Context.SECURITY_AUTHENTICATION, security);
        env.put(Context.SECURITY_PRINCIPAL, loginDetails.getDn());
        env.put(Context.SECURITY_CREDENTIALS, loginDetails.getSecret());

        try {
            dirContext = new InitialDirContext(env);
            return true;

        } catch (Exception e){
            return false;
        }
    }

    public boolean close(){
        try {
            if (dirContext != null)
                dirContext.close();
            return true;
        }catch (Exception e){
            return false;
        }
    }

    public DirContext getDirContext() {
        return dirContext;
    }

    public String getDomain() {
        return domain;
    }
}
