
# Samples how essentia connects to DBs.
This repository is for samples to connect a various DBs from/to essentia with using logstash and jdbc drivers. It contains only "mongodb", "mysql" and "postgresql" samples, but you should be able to connect to any database if you have jdbc and logstash in your environment.


## Required environment to run this samples

- amazon ec2

- java8

- logstash2.3.4 ("logstash-input-jdbc" and "logstash-output-jdbc" plugins)

- aq_tools 1.2.4

- install database

- [OPTIONAL] jdbc drivers (if you have a specific jar you want to use.)


## Directory structure in this repository

Each directories are independent and contain everything it needs (as dataset and jdbc jar file) except database itself. For example, if you are just interested into "mysql", then you can remove other directories as "mongodb" or "postgresql".

- mongodb    => this directory contains samples to connect to mongodb database with ess

- mysql      => this directory contains samples to connect to mysql database with ess

- postgresql => this directory contains samples to connect to postgresql with ess



## Dataset in this sample

Each sample uses us-names.csv data that comes from [https://www.briandunning.com/sample-data/us-500.zip](https://www.briandunning.com/sample-data/us-500.zip) (click and download for details).


## Common steps to run samples

1. install database you want to run

2. go to one of the directories "mongodb", "mysql" or "postgresql"

3. run "to-*.sh" (ex. `sh to-mysql.sh`)

4. run "from-*.sh" (ex. `sh from-mysql.sh`)
  "from-*.sh" script pulls data that is pushed by "to-*.sh".


