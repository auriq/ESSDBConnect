
# Essentia Category & MySQL Integration Sample

This sample is for users who want to stream your category data into mysql.


## Required environment

- essentia and aqtools

- logstash

- mysql




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


* mysql

		$ sudo yum -y install mysql-server 
		$ sudo service mysqld start # start mysql server 
		$ sudo chkconfig mysqld on # if you want to make mysql server always start when your machine reboot.




## How to run sample shells

* to-mysql.sh

	This sample will create category, db schema and stream category data into the mysql table.

		$ sh to-mysql.sh

* from-mysql.sh

	This sample will pull data from mysql that is stored by "to-mysql.sh" and pipe it to aq commands.

		$ sh from-mysql.sh





