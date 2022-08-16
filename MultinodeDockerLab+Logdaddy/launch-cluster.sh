#!/bin/bash
happyLaunch='Y'
launch='N'
echo "Time to build a Graylog Cluster."
echo
echo "Input O for Opensearch, or E to for Elasticsearch:"
read databaseTypeInput
echo
shopt -s nocasematch
db='O'
if ! [[ ${databaseTypeInput} =~ $db ]] ; then
    echo "Preparing to Launch 2 Graylog 2 Elastic 3 Mongo node cluster"
    echo
    echo "Which version of Graylog? Example: 4.3"
    read graylogVersionInput
    echo "Which version of MongoDB? Example: 4.4"
    read mongoVersionInput
    echo "Which version of Elasticsearch? Example: 7.10.2"
    read elasticVersionInput
    echo 
    echo "Launching Cluster using Graylog $graylogVersionInput, MongoDB $mongoVersionInput, Elasticsearch $elasticVersionInput"
    echo
    GRAYLOG_VERSION=$graylogVersionInput ELASTIC_VERSION=$elasticVersionInput MONGO_VERSION=$mongoVersionInput docker-compose -f docker-compose-elasticsearch.yml up -d
    echo "Please wait 30 seconds, after which Mongo Replica Set will be commanded to form"
    sleep 25
    echo "Intializing replica set on Mongo master"
    replicate="rs.initiate( { _id : \"graylog\", members: [ { _id: 0, host: \"mongo1:27017\" }, { _id: 1, host: \"mongo2:27017\" }, { _id: 2, host: \"mongo3:27017\" } ]}); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"mongo1:27017\"; rs.reconfig(cfg); rs.add({ host: \"mongo2:27017\", priority: 0.5 }); rs.add({ host: \"mongo3:27017\", priority: 0.5 }); rs.status();"
    docker exec -it mongo1 bash -c "echo '${replicate}' | mongo"
    echo
    echo
    echo "All done. Please wait another 60 seconds for Graylog to initiate before trying to access the ui on http://127.0.0.1:80/." 
    echo
    echo "Default logon credentials to the UI are admin/admin."
    echo
    launch='Y'
fi

db='E'
if ! [[ ${databaseTypeInput} =~ $db ]] ; then
    echo "Preparing to Launch 2 Graylog 2 Opensearch 3 Mongo node cluster"
    echo
    echo "Which version of Graylog? Example: 4.3"
    read graylogVersionInput
    echo "Which version of MongoDB? Example: 4.4"
    read mongoVersionInput
    echo "Which version of Opensearch? Example: 1.3.0"
    read elasticVersionInput
    echo 
    echo "Launching Cluster using Graylog $graylogVersionInput, MongoDB $mongoVersionInput, Opensearch $elasticVersionInput"
    echo
    GRAYLOG_VERSION=$graylogVersionInput ELASTIC_VERSION=$elasticVersionInput MONGO_VERSION=$mongoVersionInput docker-compose -f docker-compose-opensearch.yml up -d
    echo "Please wait 30 seconds, after which Mongo Replica Set will be commanded to form"
    sleep 25
    echo "Intializing replica set on Mongo master"
    replicate="rs.initiate( { _id : \"graylog\", members: [ { _id: 0, host: \"mongo1:27017\" }, { _id: 1, host: \"mongo2:27017\" }, { _id: 2, host: \"mongo3:27017\" } ]}); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"mongo1:27017\"; rs.reconfig(cfg); rs.add({ host: \"mongo2:27017\", priority: 0.5 }); rs.add({ host: \"mongo3:27017\", priority: 0.5 }); rs.status();"
    docker exec -it mongo1 bash -c "echo '${replicate}' | mongo"
    echo
    echo
    echo "All done. Please wait another 60 seconds for Graylog to initiate before trying to access the ui on http://127.0.0.1:80/." 
    echo
    echo "Default logon credentials to the UI are admin/admin."
    echo
    launch='Y'
fi
if ! [[ $launch =~ $happyLaunch ]] ; then
    echo
    echo "Yo galaxy brain, if you are reading this you managed to input a value that wasn't O or E."
    echo
    echo "Please re-launch the script to try again."
    echo
fi