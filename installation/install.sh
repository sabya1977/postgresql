# Install and configure PostgreSQL 17 on Oracle Linux 9
# as root
useradd -u 54323 -g wheel sabya
# Install the repository RPM:
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#
# Disable the built-in PostgreSQL module:
sudo dnf -qy module disable postgresql
#
# Install PostgreSQL:
sudo dnf install -y postgresql17-server
#
# Configure PostgreSQL Database cluster
# as root
mkdir /pgdata/17/data
chown postgres /pgdata/17/data
su postgres
initdb -D /pgdata/17/data
#
# You can use the below command too to start PostgreSQL
/usr/pgsql-17/bin/pg_ctl -D /pgdata/17/data -l logfile start
#
# To enable PostgreSQL using Systemd
sudo systemctl enable postgresql-17
sudo systemctl start postgresql-17
#
# Configure PostgreSQL for remote connection
#
# as postgres user
su postgres
# get the path of the postgresql.conf 
psql -U postgres -c 'SHOW config_file'
#            config_file
# ---------------------------------
#  /pgdata/17/data/postgresql.conf
# (1 row)
#
# change postgresql.conf
#listen_addresses = 'localhost'
listen_addresses = '*'
# check 
netstat -nlt
#
# add following lines to pg_hba.conf in config directory
# if you want omit password use trust instead of md5
host    all     	all     0.0.0.0/0       md5
host    all         all     :/0             md5
#
sudo systemctl restart postgresql-17
#
sudo -u postgres psql
ALTER USER postgres PASSWORD 'oracle';
#
sudo -u postgres psql -h orcl9 -U postgres
sudo -u postgres psql -h orcl9 -d postgres -U postgres
#
# as postgres user
psql postgres
#
# PGHOME
/usr/pgsql-17/bin/initdb
#
# as root or sabya check status of PostgreSQL
sudo -u postgres /usr/pgsql-17/bin/pg_ctl -D /pgdata/17/data status
# OR
su -c '/usr/pgsql-17/bin/pg_ctl -D /pgdata/17/data status' postgres