# liquibase-deploy-demo

1. Specify the following environment variables:
    - DEPLOY_DB_HOST
    - DEPLOY_DB_PORT
    - DEPLOY_DB_SERVICE (Oracle service)
    - DEPLOY_DB_USER
    - DEPLOY_DB_PASSWORD

2. From the root project directory run:
    - ./src/main/script/liquibase.sh to perform deployment via Liquibase
    - mvn test to run unit tests via utPLSQL