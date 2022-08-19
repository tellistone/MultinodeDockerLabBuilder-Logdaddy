A little bash script and a few docker compose files for building multi node Graylog setups in Docker.

The script will ask you to select from Elasticsearch or Opensearch, and then will ask which version of Graylog, Mongo and ES/OS to install.

Docker Compose then builds a 2 Graylog, 3 Mongo, 2 ES/OS cluster behind a nginx load balancer, using the selected version of each.

You can then connect to the cluster via http://127.0.0.1:80/

The following ports are open for data to be sent into Graylog on 127.0.0.1.

    - 514
    - 1514
    - 4739
    - 5044
    - 5555
    - 95155
    - 12201
    - 13301

Pre-Requisities:

    Docker
    Docker Compose (v3)
    Mac or Linux OS.

How to use:

    Save and unzip the folder somewhere that the current user has access to read/modify/execute.
    Navigate inside the folder and run the "launch-cluster.sh" script from the terminal. Note: on Mac you may need to chmod 775 the "launch-cluster.sh" file.
    Follow the instructions within the terminal window.
    Once your lab has been spun up, you can connect to it on http://127.0.0.1:80/
    Default logon credentials to the UI are admin/admin.

Good to know:

    All mongoDB and Elastic/Opensearch data is persistently stored in ./storage
    Graylog storage (Journal etc) is persistant but not accessible.
    There is a script in ./scripts called "mongo-cluster-comand.sh". You can run this to make the Mongo nodes form a cluster after bringing the containers up again after a shutdown.

Logdaddy:

Connect to the ubuntu-logdaddy container. Find the Logdaddy script located at /usr/share/logdaddy/logdaddy.sh

This is all configured to send logs to the cluster.

Load it with logs via your mac, in the location you unzipped the script, in the subdirectory ./scripts/logdaddy/log/

Launch it via ./logdaddy.sh in the container.

Parameters to use when launching:

-i 5     set the send-rate to that of a 5gb daily ingest cluster. Accepts all numbers, not just 5.
-t 300   set the send-rate to neatly finish in 300 seconds. Accepts all numbers, not just 300.
-l 10    set the script to loop 10x. Accepts all numbers, not just 10. Set to 0 for infinite loop.



