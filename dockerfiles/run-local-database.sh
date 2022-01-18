!/bin/bash
docker network create 'my-network'

docker run -d \
    --network 'my-network' \
    -e 'ACCEPT_EULA=Y' \
    -e 'SA_PASSWORD=localtestpw123@' \
    --name 'sqltestdb' \
    -p 1433:1433 \
    mcr.microsoft.com/mssql/server:2017-latest

sleep 20
docker ps
docker logs sqltestdb

docker exec sqltestdb /opt/mssql-tools/bin/sqlcmd \
    -S localhost -U SA -P 'localtestpw123@' \
    -Q "CREATE DATABASE mydrivingDB"
