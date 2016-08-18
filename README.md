# Samples how essentia connects to DBs.
This repository is for samples to connect a various DBs from/to essentia.


## Environment

- amazon ec2

- java8

- logstash2.3.4 ("logstash-input-jdbc" and "logstash-output-jdbc" plugins)

- aq_tools 1.2.4-2


## Dataset in this sample

Each sample uses us-names.csv data that comes from [free sample data](https://www.briandunning.com/sample-data/us-500.zip).


## Recommended steps

1. install database

2. run "to-*.sh" (ex. `sh to-mysql.sh`)

3. run "from-*.sh" (ex. `sh from-mysql.sh`)
  In "from-*.sh" script, it pulls data that is pushed by "to-*.sh".


