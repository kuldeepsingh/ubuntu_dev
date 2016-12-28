sudo docker inspect --format='{{.Id}} {{.Parent}}' $(sudo docker images --filter since=$1 -q) | python3 desc.py $1
