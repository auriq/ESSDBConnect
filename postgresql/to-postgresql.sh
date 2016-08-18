#!/bin/sh

# --
#  define variable
# --
DIR_CURR=$(cd $(dirname $0); pwd)
# -- user configuration
# category name
category_repo=local
category_name=us-names
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
logstash_conf=${logstash_confd}/to-${category_name}.conf
errorlogfname='error-log'
[ -e ${errorlogfname} ] && rm -f ${errorlogfname}


# -- select repository
ess select local

# -- define category
ORIGINAL_COLMS="S:first_name S:last_name S:company_name S:address S:city S:county S:state I:zip S:phone1 S:phone2 S:email S:web"
ess category add ${category_name} ${DIR_CURR}/data/us-500.csv --preprocess "aq_pp -f,eok,qui - -d $ORIGINAL_COLMS -eval s:full_name 'first_name + \" \" + last_name' -c full_name city state -o,notitle -" --overwrite

# -- create table
postgre_colms="full_name text, city text, state text"
postgreconnect="sudo runuser -l ${postgre_user} -c "
sudo runuser -l ${postgre_user} -c "psql -c 'create database ${postgre_dbname}'" 2>>${errorlogfname}; ret1=$?
sudo runuser -l ${postgre_user} -c "psql ${postgre_dbname} -c 'create table ${postgre_tbname} ($postgre_colms)'" 2>>${errorlogfname}; ret2=$?
sudo runuser -l ${postgre_user} -c "psql ${postgre_dbname} -c 'delete from ${postgre_tbname} '" 


# -- create conf file for logstash
postgre_driver_place=`find ./ -name postgresql-*jar`
postgre_driver_place=${DIR_CURR}/${postgre_driver_place}
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
   driver_jar_path => '${postgre_driver_place}'
   connection_string => 'jdbc:postgresql://${postgre_host}:${postgre_port}/${postgre_dbname}'
   driver_class => 'org.postgresql.Driver'
   username => '${postgre_user}'
   password => '${postgre_pswd}'
   statement => ['INSERT INTO ${postgre_tbname} (${logstash_colms}) VALUES (${logstash_vals})',${logstash_colms_quote}]
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
#sudo runuser -l ${postgre_user} -c "cat ${ffifo} | logstash -f ${logstash_conf}" >>${errorlogfname}
cat ${ffifo} | logstash -f ${logstash_conf} >>${errorlogfname}
ret=$?

if [ "$ret" -eq 0 -a `cat ${errorlogfname} | grep -c 'error'` -eq 0 ]; then
  echo "** Completed! **"
  echo " Your ${category_name} category data is stored in ${postgre_dbname}.${postgre_tbname} at local postgre"
else
  echo "++ ERROR ++"
  echo " logstash is failed."
  echo " Check log file '${errorlogfname}'"
  exit
fi


sudo runuser -l ${postgre_user} -c "psql ${postgre_dbname} -c 'select * from ${postgre_tbname} '" 

