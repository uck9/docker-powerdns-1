# PowerDNS Docker Container

* Based on Alpinelinux (Image size: ~45MB)
* MySQL and SQLite Backends
* Helper Scripts

## Run and config

Init the Database: [powerdns.sql](docs/powerdns.sql)

```bash
sudo docker run \
  --rm \
  --name powerdns \
  --env MYSQL_HOST=mysql \
  --env MYSQL_DB=powerdns \
  --env MYSQL_USER=powerdns \
  --env MYSQL_PWD=verysecret \
  --env OPTS="" \
  -p 53:53 -p 53:53/udp \
  psi/powerdns start
```

Use `OPTS` for additional pdns_server arguments.

## Helper scripts

* List all manage commands `sudo docker exec powerdns manage commands`
* * `start`: Start PowerDNS daemon
* * `stop`: Stop PowerDNS daemon
* * `running`: Check if PowerDNS is running
* * `pid`: Get the PowerDNS daemon PID 
* * `help [command]`: Show help (for a command)
* * `prepare`: Prepare the environment
* * `listoptions`: List all PowerDNS cli options
* * `addrecord`: Add an record to MySQL
* * `delrecord`: Remove an record from MySQL

### add / del records
`manage addrecord` and `manage delrecord` are simple helper scripts to add/delete
DNS records for existing zones. Every Record needs an uniqe identifier

* Create A record for service1.example.com with IP 1921.68.0.5:
```bash
sudo docker exec powerdns manage addrecord example.com service1 A 192.168.0.5 180 service1-ident
```

* Delete the record with Ident *service1-ident*
```bash
sudo docker exec powerdns manage delrecord service1-ident
```

### Docker DNS Service Discovery
> **This is a POC!**

Monitor Docker Container start/stop and update PowerDNS.
See [update-from-docker](update-from-docker) script.

* Listen for `start` and `die` docker events
* On start: add a subdomain with the container-name and ip to the DNS
* On stop: remove the record by the container-id
* includes events from the past 5 minutes to respect early started containers

