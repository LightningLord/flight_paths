# flight_paths

## GET <base_endpoint>/flight_paths.json

returns the starting airport and ending airport

Query parameters
airports (required)- comma separated list of airports ordered chronologically
example: If a traveler departed from OAK to PDX, then PDX to HNL, then HNL to OGG, the request would be:
flight_paths.json?airports=OAK,PDX,PDX,HNL,HNL,OGG

the return value of this request would be ['OAK', OGG']

note- the connecting flights can be out of order, but the starting point and ending point of each connection MUST be in order.
For example, the above query could be airports=PDX,HNL,OAK,PDX,HNL,OGG

## POST <base_endpoint>/flight_paths.json

returns the starting airport and ending airport

Body parameters
airports (required)- two dimensional array of connecting flights. Each inner array must have two ordered elements, the first is the departure point, and the second is the arrival point.

example: If a traveler departed from OAK to PDX, then PDX to HNL, then HNL to OGG, the body would be:
airports=[["IND", "EWR"], ["SFO"," ATL"], ["GSO", "IND"], ["ATL","GSO"]]

the return value of this request would be ['OAK', OGG']
