#!/bin/sh


# --
# create category
# --
ess select local
category_name=us-names
# --
# mongodb name
# --
mongodb_dbname=test

DIR_CURR=$(cd $(dirname $0); pwd)
ess category add ${category_name} ${DIR_CURR}/data/us-500.csv --overwrite


#mongo --eval "use ${mongodb_dbname}"
mongo --eval "db.${mongodb_dbname}.remove({})"
ess stream "${category_name}" "*" "*" "aq_pp -f,eok,qui - -d %cols -o,jsn -" | while read line; do\
  mongo --eval "db.${mongodb_dbname}.insert($line)" 2>&1 > iranai
done

mongo --eval "db.${mongodb_dbname}.stats()"
mongo --eval "db.${mongodb_dbname}.find({}).count()"


