#!/bin/sh

DIR_CURR=$(cd $(dirname $0); pwd)

# --
# mongodb name
# --
mongodb_dbname=test


mongo --eval "db.${mongodb_dbname}.find().forEach(printjsononeline)" | aq_pp -f,eok,qui,jsn - -d s:fname:first_name s:email:email


