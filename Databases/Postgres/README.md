Postgres installation 
Steps:
apt install lsb-core

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
apt update
apt install postgresql postgresql-client -y

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update
sudo apt-get -y install postgresql



- sudo apt update
- sudo apt install postgresql postgresql-contrib
- sudo systemctl start postgresql
- sudo systemctl enable postgresql
- sudo -u postgres psql

psql -h localhost -d mydatabase -U myuser



CREATE DATABASE jugnuDB;
CREATE USER jugnu WITH PASSWORD 'mypassword';
ALTER ROLE jugnu SET client_encoding TO 'utf8';
ALTER ROLE jugnu SET default_transaction_isolation TO 'read committed';
ALTER ROLE jugnu SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE jugnuDB TO jugnu;


\q




uninstall 
sudo apt remove --purge postgresql postgresql-contrib
sudo rm -rf /etc/postgresql/
sudo rm -rf /etc/postgresql-common/
sudo rm -rf /var/lib/postgresql/
sudo userdel -r postgres
sudo apt autoremove



