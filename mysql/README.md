
# Essentia Category & MySQL Integration Sample

This sample illustrates how essentia connects to a MySQL database using Logstash and its jdbc driver.


## Required environment

- essentia and aqtools

- Logstash

- MySQL




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


* MySQL

		$ sudo yum -y install mysql-server 
		$ sudo service mysqld start # start MySQL server 
		$ sudo chkconfig mysqld on # if you want to make MySQL server always start when your machine reboot.




## How to run sample shells

* to-mysql.sh

	This script will create a category, db schema and stream that category's data into a MySQL table.

		$ sh to-mysql.sh

* from-mysql.sh

	This script will pull data from MySQL that was stored using the script "to-mysql.sh" and pipe it to aq commands.

		$ sh from-mysql.sh

These sample scripts use a category representing the "us-names" dataset included in this github repository and a sample MySQL database and table. However, these scripts can be edited to stream data from different categories into different MySQL databases or to take data from different MySQL databases and send it into various linux or aq commands.



