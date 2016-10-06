
# Essentia Category & MySQL Integration Sample

This sample is for users who want to stream your category data into mysql.
This sample uses below tools and assumed to be installed.

- essentia and aqtools

- logstash

- mysql

---

## to-mysql.sh

This sample will create mysql table scheme, and take data from your defined category and stream it into the table if you provide argument to this shell as,

1. repository name

2. category name

3. mysql host name

4. mysql port number (usually default is set to 3306, but check your mysql config)

5. mysql user name

6. mysql password

7. mysql database name (if there does not exits, it will create)

8. [OPTIONAL] mysql table name (if it is not provided, script will generate a name based on category name and repository name)

So the executing syntax will look like

`$ sh to-mysql.sh repository_name category_name mysql_host mysql_port mysql_user mysql_passwd mysql_database`

This script requires :

- category is already defined.

- mysql port is open to this server where you run this script.


## hardcoded directory

This directory contains a set of sample which will run without any changes except,

- mysql username/password at your local


