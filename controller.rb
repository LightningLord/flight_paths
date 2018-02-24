require 'sinatra'
require 'json'

get '/flight_paths.json' do
  flights = create_connections(params[:airports])
  endpoints = get_endpoints(flights)
  content_type :json
  endpoints.to_json
end

post '/flight_paths.json' do
  airports = JSON.parse(params[:airports])
  endpoints = get_endpoints(airports)
  content_type :json
  endpoints.to_json
end

def create_connections(airports_csv)
  airports = airports_csv.split(',')
  flights = []
  airports.length.times do |n|
    next unless n % 2 == 0
    flights << [airports[n], airports[n+1]]
  end
  flights
end

def get_endpoints(flights)

  flight_data = {}
  flights.each do |flight|
    departure_airport = flight.first
    arrival_airport = flight.last
    flight_data[departure_airport] = update_airport_hash(flight_data[departure_airport], :start)
    flight_data[arrival_airport] = update_airport_hash(flight_data[arrival_airport], :end)
  end
  start_point = flight_data.find{|airport, data| data[:count] == 1 && data[:start] == 1 && data[:end] == 0}
  end_point = flight_data.find{|airport, data| data[:count] == 1 && data[:start] == 0 && data[:end] == 1}

  if start_point && end_point
    [start_point.first, end_point.first]
  else
    "Error: start: #{start_point.first}, end: #{end_point.first}"
  end
end

def update_airport_hash(existing_data, description)
  existing_data ||= Hash.new(0)
  existing_data[:count] += 1
  existing_data[description] += 1
  existing_data
end
