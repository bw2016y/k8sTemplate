#!/bin/bash

source /etc/profile
/etc/init.d/ssh start
service mysql start
service apache2 start
/usr/local/zookeeper/bin/zkServer.sh start

ssh slave1 "bash /run.sh"
ssh slave2 "bash /run.sh"

/usr/local/hadoop/sbin/start-all.sh

/usr/local/hbase/bin/start-hbase.sh

/usr/local/spark/sbin/start-all.sh

hive --service hiveserver2 &
hive --service metastore &

sleep 10

/usr/local/apache-kylin-2.6.4-bin/bin/kylin.sh start

/usr/local/spark/bin/spark-submit --master spark://localhost:7077 --class com.daslab.smartinteract.SpringBootApp --driver-memory 16g --executor-memory 16g --total-executor-cores 32 /root/smartinteract-5.14-Vir.jar

tail -f /dev/null



