# Security

## Managing users
- Identity, who is interfacing with the database?
- Authentication, verify the truth of a user that has identified in Scylla
- Users and passwords, managed from cql with cqlsh against system\_auth ks), with passwd feeded through cryptographic hasing function `cript_r` from GNU C library (bcrypt when available by the OS and SHA-512)
- Users metadata is replicated (RF) through the ring/nodes
- Identity in Enterprises supported through [LDAP](https://enterprise.docs.scylladb.com/stable/operating-scylla/security/ldap-authentication.html)

## Authentication
- Disabled by default
- It can be [enabled](https://opensource.docs.scylladb.com/stable/operating-scylla/security/runtime-authentication) without downtime (move the `authenticator` to `TransitionalAuthenticator` to finally move it to `PasswordAuthenticator`)
- It is recommended to have a 1:1 relation between user and application

## Roles and Permissions
With `Authorization` (which is the process to grant permissions to users) we can provide fixed permissions per user/role. It is done (enabled/disabled) providing it per CQL operation. To avoid the hard work of assigning appropriate permissions to each user we use `Roles` (see [RBAC (Role Based Access Control)](https://opensource.docs.scylladb.com/stable/operating-scylla/security/rbac-usecase) for further details), which is a collection of permissions and where roles can be granted users or to other roles as well. Therefore, we can assign the same role to different users (all these users with the same role will be able to execute the same operations). All users are roles but not all roles are users and this is the main reason/explanation why roles can be assigned to roles.
Scylla can audit events and log them to tables or Syslog, like for example on `audit.audit_log` table.

## Encryption
- Disabled by default
- Two types: 
    - [in Transit, Client to Node](https://opensource.docs.scylladb.com/stable/operating-scylla/security/client-node-encryption) or [in Transit, Node to Node](https://opensource.docs.scylladb.com/stable/operating-scylla/security/node-node-encryption)
    - [At Rest](https://enterprise.docs.scylladb.com/stable/operating-scylla/security/encryption-at-rest.html) (available only on the Enterprise version)

## Auditing
- There are 3 audit storage alternatives: None (disabled and it is the default), Table (stored in `audit.audit_log` table) or Syslog.
- There are 5 types of audit: AUTH (login events), DML (Data Manipulation Language events), DDL (Data Definition Language events), DCL (Data Control Language events) or QUERY (loggin all queries)
- It is defined/enabled at table or ks level

## Network Exposure
Best practices:
- ensure Scylla runs in a trusted network
- limit IP / Port access by role
- use the minimal privileges principle
- avoid public IP
- use VPC if possible
