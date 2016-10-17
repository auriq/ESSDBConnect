
# Sample : How essentia connects to DBs.
This repository illustrates how Essentia connects to various DBs using logstash and jdbc drivers. It contains samples for connecting to the "mongodb", "mysql" and "postgresql" databases. However, you should be able to connect to any database as long as you have Java, Logstash with its jdbc input/output plugins, and that database's jdbc driver in your environment.


## Environment used in this sample

- amazon ec2

- Java8

- logstash2.3.4 ("logstash-input-jdbc" and "logstash-output-jdbc" plugins)

- aq_tools 1.2.4

- install database

- [OPTIONAL] jdbc drivers (if you have a specific jar you want to use.)


## Directories in this repository

Each directory is independent of each other and contains everything it needs (such as a dataset and the database's jdbc jar file) except for the database itself. For example, if you are just interested in "mysql", then you can remove the other directories such as "mongodb" and "postgresql".



## Dataset in this sample

Each sample uses us-names.csv data that comes from [https://www.briandunning.com/sample-data/us-500.zip](https://www.briandunning.com/sample-data/us-500.zip) (click and download for details).



