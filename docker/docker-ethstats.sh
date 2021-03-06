echo "
Welcome to
  _____ ____  ____   ____  ____    ____  ____   _       ___     __  __  _ 
 / ___/|    \|    \ |    ||    \  /    ||    \ | |     /   \   /  ]|  |/ ]
(   \_ |  o  )  D  ) |  | |  _  ||   __||  o  )| |    |     | /  / |  ' / 
 \__  ||   _/|    /  |  | |  |  ||  |  ||     || |___ |  O  |/  /  |    \ 
 /  \ ||  |  |    \  |  | |  |  ||  |_ ||  O  ||     ||     /   \_ |     
 \    ||  |  |  .  \ |  | |  |  ||     ||     ||     ||     \     ||  .  |
  \___||__|  |__|\_||____||__|__||___,_||_____||_____| \___/ \____||__|\_|
The South African Private Blockchain Network
This script starts an instance of the Ethereum Stats Dashboard in a Docker vm
The instance is preconfigured for the South African Blockchain Consortium network.
# Script name       : docker-ethstats.sh
# Author            : Gary De Beer (BankservAfrica)
# Last Modifiy Date : 03/02/2017 
#USAGE NOTES:
===========
This script is installed as part of springblock/Ethereum Git repo.

There should only be one instance of this dashboard running as all Ethereum nodes should be publishing to it.
"

# remove any previous version of the docker image
docker rm ethstats

# get IPs from ifconfig and dig and display for information
LOCALIP=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | head -n1 | awk '{print $2}' | cut -d':' -f2)
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo "Local IP: $LOCALIP"
echo "Public IP: $IP"

#DO NOT CHANGE THESE VALUES
PORT=3000

#This is the stats webserver details
URL="http://$IP:$PORT"
OTHERPARAMS=" "

# Display the settings being used on startup
echo "Startup parameters: (edit script to alter)"
echo "PORT       = $PORT"
echo " "

echo " 
Starting up dashboard at $URL
"
docker run -it --name ethstats --network="host" -p $PORT:$PORT springblock/ethnetstats 
