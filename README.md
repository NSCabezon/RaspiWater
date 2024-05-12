# Readme

## 1. Install postgress

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


### Linux

Install 

```
sudo apt install postgresql
```

Check if postgres boots at startup

```
sudo systemctl is-enabled postgresql
```

Add user postgres

```
sudo -u postgres psql
```


### Create database

Log into postgres with `postgres` user
```
psql postgres
```

Create dabase `raspiwater`
```
create database raspiwater;
```

### Other useful commands postgres


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

Delete database:

```bash
DROP DATABASE raspiwater;
```

[Link](https://www.cyberciti.biz/faq/howto-add-postgresql-user-account/)


## Run server

To run server and be accessible outside localhost, execute the following command:

(`-b` for `binding`)

```bash
swift run App serve -b 0.0.0.0 --env development
```

to log all available routes:

```bash
routes
```


### Enable I2C

I2C enabling

```bash
sudo raspi-config
```

Select 3 interface options -> I4 interface options


#### Check I2C connection

Install I2C tools

```bash
sudo apt-get install i2c-tools
```


## WiringPI

To be able to use `gpio` command

```bash
sudo apt-get install wiringpi
```



### fetch the source

```bash
sudo apt install git
git clone https://github.com/WiringPi/WiringPi.git
cd WiringPi
```
### build the package

```bash
./build debian
mv debian-template/wiringpi-3.0-1.deb .
```

### install it

```bash
sudo apt install ./wiringpi-3.0-1.deb
```


## Read from disk values


file at path: 

```bash
/sys/bus/iio/devices/iio:device0/in_voltage0-voltage1_raw
```
