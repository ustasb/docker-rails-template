# Gets run after PostgreSQL is started.
gosu postgres postgres --single <<- SQL
  CREATE USER myapp_user with CREATEDB;
SQL
