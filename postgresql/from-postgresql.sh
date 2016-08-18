#!/bin/sh

# --
#  define variable
# --
DIR_CURR=$(cd $(dirname $0); pwd)
# -- user configuration
# category name
category_repo=local
data_name=us-names
# postgre
postgre_host=localhost
postgre_port=5432
postgre_user=postgres
postgre_pswd=essentia
postgre_dbname=posgres_logstash_sample_database
postgre_tbname=posgres_logstash_sample_table


# -- define vars based on user specification
# logstash
logstash_confd=${DIR_CURR}/conf
[ ! -e ${logstash_confd} ] && mkdir -p ${logstash_confd}
logstash_conf=${logstash_confd}/to-${data_name}.conf
errorlogfname='error-log'
[ -e ${errorlogfname} ] && rm -f ${errorlogfname}

# -- create conf file for logstash
postgre_driver_place=`find ./ -name postgresql-*jar`
postgre_driver_place=${DIR_CURR}/${postgre_driver_place}
echo "
input {
 jdbc {
   jdbc_driver_library => '${postgre_driver_place}'
   jdbc_connection_string => 'jdbc:postgresql://${postgre_host}:${postgre_port}/${postgre_dbname}'
   jdbc_driver_class => 'org.postgresql.Driver'
   jdbc_user => '${postgre_user}'
   jdbc_password=> '${postgre_pswd}'
   statement => ['SELECT * FROM ${postgre_tbname}'] 
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
logstash -f ${logstash_conf} 2>>${errorlogfname} | aq_pp -f,eok,qui,jsn - -d s:fname:full_name s:city:city s:state:state
ret=$?

if [ "$ret" -eq 0 -a `cat ${errorlogfname} | grep -c 'error'` -eq 0 ]; then
  echo "** Completed! **"
  echo " Your ${data_name} category data is stored in ${postgre_dbname}.${postgre_tbname} at local postgre"
else
  echo "++ ERROR ++"
  echo " logstash is failed."
  echo " Check log file '${errorlogfname}'"
  exit
fi



