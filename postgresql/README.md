
# Essentia Category & PostgreSQL Integration Sample

This sample illustrates how essentia connects to PostgreSQL database with using Logstash and its jdbc driver.


## Required environment

- essentia and aqtools

- Logstash

- PostgreSQL




## Install tips

Installation process usually depends on which environment you use, so please refere to the official site for details (Samples below worked on ec2 instance).

* Java8

	Logstash requires Java8. If you do not have it in your environment, run the following

		$ sudo yum install -y java-1.8.0 java-1.8.0-openjdk-devel

	If you already have Java8, but is set to other version, then run it and choose version8.

		$ sudo /usr/sbin/alternatives --config java


* Logstash

	Pull tar file from [the official](https://www.elastic.co/downloads/logstash) and uncompress.

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

	This script will create category, db schema and stream category data into the PostgreSQL table.

		$ sh to-postgresql.sh

* from-postgresql.sh

	This script will pull data from PostgreSQL that is stored by "to-postgresql.sh" and pipe it to aq commands.

		$ sh from-postgresql.sh





