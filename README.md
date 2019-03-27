# PL/SQL project with Liquibase and utPLSQL

1. TECH_USER should be created in the following way:

```sql
CREATE USER tech_user IDENTIFIED BY tech_user
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

ALTER USER tech_user QUOTA unlimited ON users;

GRANT CONNECT TO tech_user;

GRANT CREATE PROCEDURE to tech_user;

GRANT CREATE TABLE TO tech_user;

GRANT CREATE VIEW TO tech_user;

GRANT CREATE SEQUENCE TO tech_user;

GRANT CREATE PUBLIC SYNONYM TO tech_user;

GRANT DROP PUBLIC SYNONYM TO tech_user;

--grants needed for pk_util_parallel_execute package
GRANT CREATE JOB TO tech_user;

GRANT EXECUTE ON DBMS_LOCK TO TECH_USER;

grant manage scheduler to tech_user;
```

2. Specify the following environment variables:
    - DEPLOY_DB_HOST
    - DEPLOY_DB_PORT
    - DEPLOY_DB_SERVICE (Oracle service)
    - DEPLOY_DB_USER
    - DEPLOY_DB_PASSWORD

3. From the root project directory run:
    - ./src/main/script/liquibase.sh to perform deployment via Liquibase
    - mvn test to run unit tests via utPLSQL