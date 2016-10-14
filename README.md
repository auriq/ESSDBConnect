
# Sample : How essentia connects to DBs.
This repository illustrates how essentia connects a various DBs with using logstash and jdbc drivers. It contains only "mongodb", "mysql" and "postgresql" samples, but you should be able to connect to any database if you have jdbc and logstash in your environment.


## Environment used in this sample

- amazon ec2

- Java8

- logstash2.3.4 ("logstash-input-jdbc" and "logstash-output-jdbc" plugins)

- aq_tools 1.2.4

- install database

- [OPTIONAL] jdbc drivers (if you have a specific jar you want to use.)


## Directories in this repository

Each directory is independent of each other and contains everything it needs (as dataset and jdbc jar file) except database itself. For example, if you are just interested into "mysql", then you can remove other directories as "mongodb" or "postgresql".



## Dataset in this sample

Each sample uses us-names.csv data that comes from [https://www.briandunning.com/sample-data/us-500.zip](https://www.briandunning.com/sample-data/us-500.zip) (click and download for details).



