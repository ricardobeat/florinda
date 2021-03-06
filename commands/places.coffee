request = require 'request'
qs      = require 'querystring'
decode  = require '../lib/entity_decode.js'

## Google Places

placeSearch = (query, respond) ->

    message = ''
    
    url = 'https://maps.googleapis.com/maps/api/place/search/json?' + qs.stringify(
        location: '-30.032765,-51.221094'
        radius: 200
        name: query
        sensor: true
        key: config.maps.apiKey
    )
    
    console.log "requesting #{url}" if program.verbose
    request.get url, (err, resp, body) ->
        data = JSON.parse body
        
        if place = data.results?[0]
            message = "#{place.name} is at #{place.vicinity}"
        else
            message = "I'm sorry, I couldn't find '#{query}'."
        
        respond message

# search for shit on twitter
# search shit on twitter
brain.addPattern 'places',
    match: /^where is ([^?]+) ?\??/i
    fn: (user, m, cb) -> placeSearch m[1], cb

