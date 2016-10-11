
# Essentia Category & PostgreSQL Integration Sample

This sample is for users who want to stream your category data into postgresql.


## Required environment

- essentia and aqtools

- logstash

- postgresql




## Install tips

Installation process usually depends on which environment you use, so please refere to the official site for details.
(samples below worked on ec2 instance)

* java

	Since logstash needs java, if you do not have java in your environment, 

		$ sudo yum install -y java-1.8.0 java-1.8.0-openjdk-devel

	If you already have java8, but is set to other version, then run it and choose version8.

		$ sudo /usr/sbin/alternatives --config java


* logstash

	Pull tar file from [the official](https://www.elastic.co/downloads/logstash) and uncompress.

		$ wget https://download.elastic.co/logstash/logstash/logstash-2.3.4.tar.gz
		$ gunzip logstash-2.3.4.tar.gz
		$ tar -xvf logstash-2.3.4.tar


* logstash jdbc plugin

		$ cd logstash-2.3.4
		$ bin/logstash-plugin install logstash-input-jdbc
		$ bin/logstash-plugin install logstash-output-jdbc


* postgresql

		$ sudo yum install -y libxslt.i686 
		$ sudo yum install -y postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs 
		$ sudo service postgresql initdb # init db
		$ sudo service postgresqld start # start postgresql server 
		$ sudo chkconfig postgresqld on  # if you want to make postgresql server always start when your machine reboot.




## How to run sample shells

* to-postgresql.sh

	This sample will create category, db schema and stream category data into the postgresql table.

		$ sh to-postgresql.sh

* from-postgresql.sh

	This sample will pull data from postgresql that is stored by "to-postgresql.sh" and pipe it to aq commands.

		$ sh from-postgresql.sh





