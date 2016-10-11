
# Essentia Category & Mongodb Integration Sample

This sample is for users who want to stream your category data into mongodb.


## Required environment

- essentia and aqtools

- logstash

- mongodb




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


* mongodb

	Please refere to the mongodb's official site as [this](https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-amazon/), but briefly speaking, 

	1. configure yum
	1. install mongodb

		`$ sudo yum install -y mongodb-org`

	1. start mongodb

		`$ sudo service mongod start`



## How to run sample shells

* to-mongodb.sh

	This sample will create category and stream it into the mongodb table.

		$ sh to-mongodb.sh

* from-mongodb.sh

	This sample will pull data from mongodb that is stored by "to-mongodb.sh" and pipe it to aq commands.

		$ sh from-mongodb.sh





