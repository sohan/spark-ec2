#!/bin/bash

pushd /root

if [ -d "shark" ]; then
  echo "Shark seems to be installed. Exiting."
  popd
  return
fi

# Github tag:
if [[ "$SHARK_VERSION" == *\|* ]]
then
  # Not yet supported
  echo ""
# Pre-package shark version
else
  case "$SHARK_VERSION" in
    0.7.0)
      if [[ "$HADOOP_MAJOR_VERSION" == "1" ]]; then
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.7.0-hadoop1-bin.tgz
      else
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.7.0-hadoop2-bin.tgz
      fi
      ;;    
    0.7.1)
      if [[ "$HADOOP_MAJOR_VERSION" == "1" ]]; then
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.7.1-hadoop1-bin.tgz
      else
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.7.1-hadoop2-bin.tgz
      fi
      ;;    
    0.8.0)
      wget http://archive.cloudera.com/cdh5/cdh/5/hive-0.12.0-cdh5.0.2.tar.gz
      if [[ "$HADOOP_MAJOR_VERSION" == "1" ]]; then
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.8.0-bin-hadoop1.tgz
      else
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.8.0-bin-cdh4.tgz
      fi
      ;;
    0.8.1)
      wget http://archive.cloudera.com/cdh5/cdh/5/hive-0.12.0-cdh5.0.2.tar.gz
      if [[ "$HADOOP_MAJOR_VERSION" == "1" ]]; then
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.8.1-bin-hadoop1.tgz
      else
        wget http://s3.amazonaws.com/spark-related-packages/shark-0.8.1-bin-cdh4.tgz
      fi
      ;;
    0.9.0 | 0.9.1)
      if [[ "$HADOOP_MAJOR_VERSION" == "1" ]]; then
        wget https://s3.amazonaws.com/spark-related-packages/shark-0.9.1-bin-hadoop1.tgz
      else
        wget https://s3.amazonaws.com/spark-related-packages/shark-0.9.1-bin-hadoop2.tgz
      fi
      ;;
    *)
      echo "ERROR: Unknown Shark version"
      popd
      return
  esac

  echo "Unpacking Shark"
  tar xvzf shark-*gz > /tmp/spark-ec2_shark.log
  rm shark-*.tgz
  mv `ls -d shark-*` shark

  if stat -t hive*gz >/dev/null 2>&1; then
    echo "Unpacking Hive"
    # NOTE: don't rename this because currently HIVE_HOME is set to "hive-0.9-bin".
    #       Could be renamed to "hive" in the future to support multiple hive
    #       versions associated with different shark versions.
    tar xvzf hive-*gz > /tmp/spark-ec2_hive.log
    rm hive-*gz
    mv `ls -d hive-*` hive
  fi
fi

popd
