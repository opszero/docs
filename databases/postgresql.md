# PostgreSQL

## Create a User

```
CREATE USER newuser123 WITH PASSWORD 'foobar123';

GRANT CONNECT ON DATABASE database_name TO newuser123;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO newuser123;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO newuser123;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO newuser123;
```

### Turn User into Super User

```
ALTER USER newuser123 WITH SUPERUSER; #Uncomment for superuser
```
