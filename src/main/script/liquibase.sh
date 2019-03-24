#!/usr/bin/bash

mvn liquibase:update -Dliquibase.promptOnNonLocalDatabase=false \
    -Dojdbc.version=12.1.0.2.0 \
    -Dliquibase.url=jdbc:oracle:thin:@//$DEPLOY_DB_HOST:$DEPLOY_DB_PORT/$DEPLOY_DB_SERVICE \
    -Dliquibase.username=$DEPLOY_DB_USER \
    -Dliquibase.password=$DEPLOY_DB_PASSWORD \
    -Dliquibase.changeLogDirectory="src/main/resources/oracle/tech_user"
