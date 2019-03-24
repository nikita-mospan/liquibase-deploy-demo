#!/usr/bin/bash

mvn liquibase:update -Dliquibase.promptOnNonLocalDatabase=false \
    -Dojdbc.version=12.1.0.2.0 \
    -Dliquibase.url=$LIQUIBASE_URL \
    -Dliquibase.username=$LIQUIBASE_USER \
    -Dliquibase.password=$LIQUIBASE_PASSWORD \
    -Dliquibase.changeLogDirectory="src/main/resources/oracle/tech_user"
