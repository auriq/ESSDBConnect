
# Essentia Category & Mongodb Integration Sample

This sample illustrates how essentia connects to MongoDB database.


## Required environment

- essentia and aqtools

- MongoDB




## Install tips

Installation process usually depends on which environment you use, so please refere to the official site for details (Samples below worked on ec2 instance).

* MongoDB

	Please refere to the MongoDB's [official](https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-amazon/), but briefly speaking, 

	1. configure yum
	1. install MongoDB

		`$ sudo yum install -y mongodb-org`

	1. start MongoDB

		`$ sudo service mongod start`



## How to run sample shells

* to-mongodb.sh

	This script will create category and stream it into the MongoDB table.

		$ sh to-mongodb.sh

* from-mongodb.sh

	This script will pull data from MongoDB that is stored by "to-mongodb.sh" and pipe it to aq commands.

		$ sh from-mongodb.sh





