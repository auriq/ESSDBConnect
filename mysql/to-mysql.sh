#!/bin/sh

# --
#  define variable
# --
DIR_CURR=$(cd $(dirname $0); pwd)
# -- user configuration
# category name
category_repo=local
category_name=us-names
# mysql
mysql_host=localhost
mysql_port=3306
mysql_user=root
mysql_pswd=essentia
mysql_dbname=MYSQL_LOGSTASH_SAMPLE_DATABASE
mysql_tbname=MYSQL_LOGSTASH_SAMPLE_TABLE


# -- define vars based on user specification
# logstash
logstash_confd=conf
[ ! -e ${logstash_confd} ] && mkdir -p ${logstash_confd}
logstash_conf=${logstash_confd}/to-${category_name}.conf
errorlogfname='error-log'
[ -e ${errorlogfname} ] && rm -f ${errorlogfname}


# -- select repository
ess select local

# -- define category
ORIGINAL_COLMS="S:first_name S:last_name S:company_name S:address S:city S:county S:state I:zip S:phone1 S:phone2 S:email S:web"
#ess category add ${category_name} ${DIR_CURR}/data/us-500.zip --archive "us-*.csv" --noprobe --overwrite
ess category add ${category_name} ${DIR_CURR}/data/us-500.csv --preprocess "aq_pp -f,eok,qui - -d $ORIGINAL_COLMS -eval s:full_name 'first_name + \" \" + last_name' -c full_name city state -o,notitle -" --overwrite

# -- create table
mysql_colms="full_name varchar(255) DEFAULT NULL, city varchar(255) DEFAULT NULL, state varchar(255) DEFAULT NULL"
mysqlconnect="mysql -h ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p${mysql_pswd}"
$mysqlconnect -e "CREATE DATABASE IF NOT EXISTS ${mysql_dbname}" 2>>${errorlogfname}; ret1=$?
$mysqlconnect -e "DROP TABLE IF EXISTS ${mysql_dbname}.${mysql_tbname}" 2>>${errorlogfname}; ret2=$?
$mysqlconnect -e "CREATE TABLE ${mysql_dbname}.${mysql_tbname} ($mysql_colms)" 2>>${errorlogfname}; ret3=$?
if [ $ret1 -ne 0 -o  $ret2 -ne 0 -o  $ret3 -ne 0 ]; then
  echo "++ ERROR ++"
  echo " failed to create mysql table."
  echo " see details in '${errorlogfname}'"
  exit
fi


# -- create conf file for logstash
mysql_driver_place=`find ./ -name mysql-connector-java*jar`
logstash_colms="full_name,city,state"
logstash_colms_quote="'full_name','city','state'"
logstash_vals="?,?,?"
echo "
input {
   stdin { }
} 
filter { 
  csv {
    columns => [${logstash_colms_quote}]
    separator => ','
  } 
} 
output {
 jdbc {
   driver_jar_path => '${mysql_driver_place}'
   driver_class => 'com.mysql.jdbc.Driver'
   connection_string => 'jdbc:mysql://${mysql_host}:${mysql_port}/${mysql_dbname}'
   username => '${mysql_user}'
   password => '${mysql_pswd}'
   statement => ['INSERT INTO ${mysql_tbname} (${logstash_colms}) VALUES(${logstash_vals})',${logstash_colms_quote}]
 }
}
" > ${logstash_conf}


# -- 
#  1. create a fifo to stream category into fifo
#  2. cat fifo and pipe it to logstatsh with conf
# --
ffifo=/tmp/fifo-${category_name}
[ -e ${ffifo} ] && rm -f ${ffifo}
mkfifo ${ffifo}
ess stream "${category_name}" '*' '*' "aq_pp -f,eok,qui - -d %cols -o,notitle ${ffifo}" &
cat ${ffifo} | logstash -f ${logstash_conf} >>${errorlogfname}
ret=$?

if [ "$ret" -eq 0 ]; then
  echo "** Completed! **"
  echo " Your ${category_name} category data is stored in ${mysql_dbname}.${mysql_tbname} at local mysql"
else
  echo "++ ERROR ++"
  echo " logstash is failed."
  echo " Check log file '${errorlogfname}'"
  exit
fi

