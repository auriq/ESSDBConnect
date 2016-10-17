
# Essentia Category & PostgreSQL Integration Sample

This sample illustrates how essentia connects to a PostgreSQL database using Logstash and its jdbc driver.


## Required environment

- essentia and aqtools

- Logstash

- PostgreSQL




## Install tips

Installation process usually depends on which environment you use, so please refer to the official site for details (the samples below are for an Amazon EC2 instance).

* Java8

	Logstash requires Java8. If you do not have it in your environment, run the following

		$ sudo yum install -y java-1.8.0 java-1.8.0-openjdk-devel

	If you already have Java8, but is set to other version, then run it and choose version8.

		$ sudo /usr/sbin/alternatives --config java


* Logstash

	Pull tar file from the [official site](https://www.elastic.co/downloads/logstash) and uncompress.

		$ wget https://download.elastic.co/logstash/logstash/logstash-2.3.4.tar.gz
		$ gunzip logstash-2.3.4.tar.gz
		$ tar -xvf logstash-2.3.4.tar


* Logstash jdbc plugin

		$ cd logstash-2.3.4
		$ bin/logstash-plugin install logstash-input-jdbc
		$ bin/logstash-plugin install logstash-output-jdbc


* PostgreSQL

		$ sudo yum install -y libxslt.i686 
		$ sudo yum install -y postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs 
		$ sudo service postgresql initdb # init db
		$ sudo service postgresqld start # start PostgreSQL server 
		$ sudo chkconfig postgresqld on  # if you want to make PostgreSQL server always start when your machine reboot.




## How to run sample shells

* to-postgresql.sh

	This script will create a category, db schema and stream that category's data into a PostgreSQL table.

		$ sh to-postgresql.sh

* from-postgresql.sh

	This script will pull data from PostgreSQL that was stored using the script "to-postgresql.sh" and pipe it to aq commands.

		$ sh from-postgresql.sh

These sample scripts use a category representing the "us-names" dataset included in this github repository and a sample PostgreSQL database and table. However, these scripts can be edited to stream data from different categories into different PostgreSQL databases or to take data from different PostgreSQL databases and send it into various linux or aq commands.



