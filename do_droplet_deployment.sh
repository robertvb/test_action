#!/bin/bash

echo '--- Starting qungle-server deployment ---'

echo 'Step 0: purge variables'

echo -e "${SSH_PRIVATE_KEY//_/\\n}" >> key.txt
chmod 400 key.txt

echo 'Step 1: connect to docker machine and update docker-compose.yml'

ssh -o StrictHostKeyChecking=no -i key.txt root@${DROPLET_IP} "cd ../qungle/qungle-server; cat > docker-compose.yml" < docker-compose.yml

echo 'Step 2: connect to docker machine and start updated docker images containers'

ssh -o StrictHostKeyChecking=no -i key.txt root@${DROPLET_IP} "cd ../qungle/qungle-server; docker-compose stop; docker-compose rm; docker-compose pull; docker-compose up -d"