set -e
psql -h phoenix -U postgres -c "create role luca with login password  'postgres' connection limit 1" postgres
psql -h phoenix -U postgres -c "create role enrico with login password 'postgres'" postgres

