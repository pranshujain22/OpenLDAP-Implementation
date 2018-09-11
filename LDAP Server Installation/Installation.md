```
$ sudo apt-get update
$ sudo apt-get install slapd ldap-utils
$ sudo dpkg-reconfigure slapd
```

- Omit OpenLDAP server configuration? No

- DNS domain name?
  - This option will determine the base structure of your directory path. Read the message to understand exactly how this will be implemented. You can actually select whatever value you'd like, even if you don't own the actual domain.
    > e.g. example.com

- Organization name?
  - You may choose anything as the name of our organization.

- Administrator password? enter a secure password twice

- Database backend? MDB

- Remove the database when slapd is purged? No
- Move old database? Yes
- Allow LDAPv2 protocol? No

At this point, your LDAP server is configured and running. Open up the LDAP port on your firewall so external clients can connect:

```
sudo ufw allow ldap
```

Let's test our LDAP connection with ldapwhoami, which should return the username we're connected as:

```
ldapwhoami -H ldap:// -x
```

```
Output
anonymous
```
