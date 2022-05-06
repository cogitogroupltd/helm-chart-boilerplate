#!/bin/bash

# Example script which will run prior to the main helm chart deploys. 
# See .Values.hooks

# Uncomment and populate these values to run locally
# export DB_NAME=devdb
# export DB_SERVER=mssql.dns.name
# export DB_USERNAME=dev
# export DB_PASSWORD=blab

export SCRIPTS=/scripts
cp $SCRIPTS/* $HOME/

sed -i -e "s/@DATABASE_NAME@/$DB_NAME/g" $HOME/create-user-and-database.sql

echo "Execution SQL script ..."
/opt/mssql-tools/bin/sqlcmd -S "$DB_SERVER" -U $DB_USERNAME -P $DB_PASSWORD -i $HOME/create-user-and-database.sql -o result.txt

cat result.txt
