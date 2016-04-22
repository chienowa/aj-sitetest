#!/bin/bash
#update an A record in digital Ocean. Dynamic DNS style.
#API info here:
#https://developers.digitalocean.com/#domains-list

# $1 action create | delete
# $2 apikey
# $3 newhost
# $4 domain
# $5 IP address of droplet

#action
if [ $1 == "create" ] ; then
    action="POST"
elif [ $1 == "delete" ] ; then
    action="DELETE"
else 
    echo "invalid action [$1]: use create or delete"
    exit 1;
fi

#do-apikey
apikey=${2:-"do-apikey"}

#record to update
record_id=${3:-"@"}

#your domain ID
domain_id=${4:-"nabelog.com"}

#ip address
ip=${5:-"188.166.177.243"}

### Check if record_id already exists.

# Get all records list and count how many same host name exists.
record="$(curl -s -H "Authorization: Bearer $apikey" -H "Content-Type: application/json" \
                 -X GET "https://api.digitalocean.com/v2/domains/$domain_id/records/" | jq '.domain_records | map(select(.name=="'"$record_id"'"))[] | .id' )"

#echo "GET: id ${record} "

#if [ `expr ${records}` -gt 0 ] ; then
#    echo "domain:${record_id} already exists"
#    exit 1;
#else
    ### don't change ###
    #ip="$(curl  http://ipecho.net/plain)"
    echo content="$(curl -s -H "Authorization: Bearer $apikey" -H "Content-Type: application/json" \
                 -d '{"type": "A", "name": "'"$record_id"'", "data": "'"$ip"'"}' \
                 -X "$action" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record")"
#fi

