
# Essentia Category & MySQL Integration Sample

This sample illustrates how essentia connects to MySQL database with using Logstash and its jdbc driver.


## Required environment

- essentia and aqtools

- Logstash

- MySQL




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


* MySQL

		$ sudo yum -y install mysql-server 
		$ sudo service mysqld start # start MySQL server 
		$ sudo chkconfig mysqld on # if you want to make MySQL server always start when your machine reboot.




## How to run sample shells

* to-mysql.sh

	This script will create category, db schema and stream category data into the MySQL table.

		$ sh to-mysql.sh

* from-mysql.sh

	This script will pull data from MySQL that is stored by "to-mysql.sh" and pipe it to aq commands.

		$ sh from-mysql.sh





