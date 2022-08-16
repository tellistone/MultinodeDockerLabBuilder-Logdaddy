#!/bin/bash
echo "Intializing replica set on master"
replicate="rs.initiate( { _id : \"graylog\", members: [ { _id: 0, host: \"mongo1:27017\" }, { _id: 1, host: \"mongo2:27017\" }, { _id: 2, host: \"mongo3:27017\" } ]}); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"mongo1:27017\"; rs.reconfig(cfg); rs.add({ host: \"mongo2:27017\", priority: 0.5 }); rs.add({ host: \"mongo3:27017\", priority: 0.5 }); rs.status();"
docker exec -it mongo1 bash -c "echo '${replicate}' | mongo"