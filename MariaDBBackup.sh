#!/bash/sh
#date
MONTH=$(/bin/date +%Y%m)
DATE=$(/bin/date +%Y%m%d)

#define PATH
PATH=/path/to/destination/

#define DB
HOST="IP"
DBNAME="root"
DBPASS="root"

#define DB Name
DB[0]='DB1'
DB[1]='DB2'
DB[2]='DB3'

echo "Starting"

# foreach
for i in "${DB[@]}"
do
	echo "Starting dump $i"
	/usr/local/bin/mysqldump  -h $HOST -u$DBNAME -p$DBPASS $i > $PATH$i.sql
	echo "Finished dump $i"
done
echo "---------------------"

echo "Ziping file"
cd $PATH
/usr/bin/zip -r SQL_$DATE.zip *.sql
echo "---------------------"

echo "Removing sql files"
for j in "${DB[@]}"
do
	echo "Removing $j"
	/bin/rm $j.sql
	echo "Removed $j"
done
echo "---------------------"

echo "Finished dump!"
