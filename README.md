# OpenLDAP-Implementation
This project implements basic operations using OpenLDAP over the Web UI using JSP and Apache Tomcat.

## Prerequisites

1. [LDAP Server](Installation.md)

2. [Apache Tomcat](http://mirrors.wuchna.com/apachemirror/tomcat/tomcat-9/v9.0.11/bin/apache-tomcat-9.0.11.tar.gz)
Download and extract tomcat in local file system.

3. [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download).
Download and intall Ultimate edition.

## Procedure

Clone git repo in local file system.

Open the project in IntelliJ IDEA Ultimate.

Edit configuration for Application Server to the extracted Apache Tomcat Server directory.

There are some changes required to perform in some java code:
  - AuthenticateUser.java
  - LDAPSearch.java

Replace the occurance of **_jarvis_** in **"dc=jarvis,dc=com"** to the domain name without the **_.com_** in each of the above .java files..

Now the code is ready to run!

Run the project and you will be redirected to the Login page in the default browser. Login with the following credentials for Admin:
> Entry DN: cn=admin,dc=<domain>,dc=com

> Password: created during the OpenLDAP setup.
