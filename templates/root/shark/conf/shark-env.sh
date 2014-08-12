#!/usr/bin/env bash

# Set Spark's memory per machine -- you might want to increase this
export SHARK_MASTER_MEM=1g

# Java options
SPARK_JAVA_OPTS+="-Dspark.kryoserializer.buffer.mb=10 "
#SPARK_JAVA_OPTS+="-verbose:gc -XX:-PrintGCDetails -XX:+PrintGCTimeStamps "
export SPARK_JAVA_OPTS

if [ -d "/root/hive" ]; then
  # Point HIVE_HOME to the Hive binary manually fetched
  # during instance setup. This only applies for Shark v0.8.
  export HIVE_HOME="/root/hive"
fi

export HADOOP_HOME=/root/ephemeral-hdfs
export HIVE_CONF_DIR=/root/ephemeral-hdfs/conf

export MASTER=`cat /root/spark-ec2/cluster-url`
export SPARK_HOME=/root/spark

export TACHYON_MASTER="tachyon://{{active_master}}:19998"
export TACHYON_WAREHOUSE_PATH="/sharktables"

source $SPARK_HOME/conf/spark-env.sh
