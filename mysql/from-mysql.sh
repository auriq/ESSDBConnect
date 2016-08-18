#!/bin/sh

# --
#  define variable
# --
DIR_CURR=$(cd $(dirname $0); pwd)
# -- user configuration
# data name
data_name=us-names
# mysql
mysql_host=localhost
mysql_port=3306
mysql_user=root
mysql_pswd=essentia
mysql_dbname=MYSQL_LOGSTASH_SAMPLE_DATABASE
mysql_tbname=MYSQL_LOGSTASH_SAMPLE_TABLE


# -- define vars based on user specification
# logstash
logstash_confd=conf; [ ! -e ${logstash_confd} ] && mkdir -p ${logstash_confd}
logstash_conf=${logstash_confd}/from-${data_name}.conf


# -- create conf file for logstash
mysql_driver_place=`find ./ -name mysql-connector-java*jar`
echo "
input {
 jdbc {
   jdbc_driver_library => '${mysql_driver_place}'
   jdbc_driver_class => 'com.mysql.jdbc.Driver'
   jdbc_connection_string => 'jdbc:mysql://${mysql_host}:${mysql_port}/${mysql_dbname}'
   jdbc_user => '${mysql_user}'
   jdbc_password => '${mysql_pswd}'
   statement => ['SELECT * FROM ${mysql_tbname}']
 }
}
output {
   stdout { codec => json_lines }
} 
" > ${logstash_conf}


# -- 
#  1. create a fifo to stream category into fifo
#  2. cat fifo and pipe it to logstatsh with conf
# --
logstash -f ${logstash_conf} | aq_pp -f,eok,qui,jsn - -d s:fname:full_name s:city:city s:state:state


