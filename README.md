# Readme

## Install postgress

### MacOS

With homebrew:

```bash
brew install postgresql
```

To start postgresql and restart at login:

```bash  
brew services start postgresql@14
```

https://medium.com/@abhinavsinha_/download-and-configure-postgresql16-on-macos-d41dc49217b6


## Create database

Log into postgres with `postgres` user
```
psql postgres
```

Create dabase `raspiwater`
```
create database raspiwater;
```


## Run server

To run server and be accessible outside localhost, execute the following command:

(`-b` for `binding`)

```bash
swift run App serve -b 0.0.0.0
```

to log all available routes:

```bash
routes
```

## Useful commands postgres


list dbs

```bash
\l
```

connect to database

```bash
\c raspiwater
```

list tables

```bash
\dt
```

Query from table:
```bash
SELECT * FROM "sensor_reading";
```
