
# Essentia Category & Mongodb Integration Sample

This sample illustrates how essentia connects to a MongoDB database.


## Required environment

- essentia and aqtools

- MongoDB




## Install tips

Installation process usually depends on which environment you use, so please refere to the [official site](https://docs.mongodb.com/v3.0/installation/) for details (the samples below are for an Amazon EC2 instance).

* MongoDB

	Please refere to MongoDB's [official instructions](https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-amazon/), but briefly speaking, 

	1. configure yum
	1. install MongoDB

		`$ sudo yum install -y mongodb-org`

	1. start MongoDB

		`$ sudo service mongod start`



## How to run sample shells

* to-mongodb.sh

	This script will create a category and stream it into a MongoDB table.

		$ sh to-mongodb.sh

* from-mongodb.sh

	This script will pull data from MongoDB that was stored using the script "to-mongodb.sh" and pipe it to aq commands.

		$ sh from-mongodb.sh

These sample scripts use a category representing the "us-names" dataset included in this github repository and a sample MongoDB database named "test". However, these scripts can be edited to stream data from different categories into different MongoDB databases or to take data from different MongoDB databases and send it into various linux or aq commands. 



