set -e
sudo -u postgres psql -h orcl9 -U postgres -c "drop role luca"
sudo -u postgres psql -h orcl9 -U postgres -c "drop role enrico"
sudo -u postgres psql -h orcl9 -U postgres -c "create role luca with login password  'postgres' connection limit 1" postgres
sudo -u postgres psql -h orcl9 -U postgres -c "create role enrico with login password 'postgres'" postgres

