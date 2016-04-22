#!/bin/bash
#update an A record in digital Ocean. Dynamic DNS style.
#API info here:
#https://developers.digitalocean.com/#domains-list

# $1 apikey
# $2 newhost
# $3 domain
# $4 IP address of droplet

#do-apikey
apikey = ${1:-"do-apikey"}

#record to update
record_id=${2:-"@"}

#your domain ID
domain_id=${3:-"nabelog.com"}

#ip address
ip=${4:-"188.166.177.243"}

### Check if record_id already exists.

# Get all records list and count how many same host name exists.
records="$(curl -s -H "Authorization: Bearer $api_key" -H "Content-Type: application/json" \
                 -d '{"type": "A", "name": "'"$record_id"'", "data": "'"$ip"'"}' \
                 -X GET "https://api.digitalocean.com/v2/domains/$domain_id/records/" | jq '.domain_records | map(select(.name=="'"$record_id"'")) | length' )"

#echo "now: ${records} exists"

if [ `expr ${records}` -gt 0 ] ; then
    echo "domain:${record_id} already exists"
    exit 1;
else
    ### don't change ###
    #ip="$(curl  http://ipecho.net/plain)"
    echo content="$(curl -s -H "Authorization: Bearer $api_key" -H "Content-Type: application/json" \
                 -d '{"type": "A", "name": "'"$record_id"'", "data": "'"$ip"'"}' \
                 -X POST "https://api.digitalocean.com/v2/domains/$domain_id/records")"
fi

