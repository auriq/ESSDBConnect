#!/bin/sh

if [ `which psql 2>&1 | grep -c "no psql"` -eq 1 ]; then
  echo "start installing psql....."
  sudo yum install -y libxslt.i686
  sudo yum install -y postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
fi

if [ `sudo service postgresql status | grep -c stopped` -eq 1 ]; then
  rslt=`sudo service postgresql start`
  if [ `echo "$rslt" | grep -c FAILED` -eq 1 ]; then
    sudo service postgresql initdb
    sudo service postgresql start
  fi
fi

# -- for local connect,
# I modified this file
# /var/lib/pgsql9/data/pg_hba.conf
# from
  ## IPv4 local connections:
  #host    all         all         127.0.0.1/32          ident
# to
  ## IPv4 local connections:
  #host    all         all         127.0.0.1/32          trust

