#!/bin/sh

if [ `which mongo 2>&1 | grep -c "no mongo"` -eq 1 ]; then
  echo "start to install mongodb."
  if [ `yum list | grep mongodb-org | wc -l` -eq 0 ]; then
    echo "[MongoDB]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
enabled=1" | sudo tee -a /etc/yum.repos.d/mongodb.repo
  fi
  if [ `yum list | grep mongodb-org | wc -l` -eq 0 ]; then
    echo "Failed to add yum repository."
    exit
  fi
  sudo yum -y install mongodb-org
else
  echo "already installed."
fi

if [ `sudo service mongod status | grep -c stopped` -eq 1 ]; then
  sudo service mongod start
fi

