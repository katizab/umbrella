require "http"
require "json"
require "dotenv/load"

pirate_weather_api_key = ENV["PIRATE_WEATHER_KEY"]
gmaps_api_key=ENV["GMAPS_KEY"]
openai_api_key=ENV["OPENAI_KEY"]

pp "Where are you?"
location=gets.chomp


# Get the user’s latitude and longitude from the Google Maps API.
google_maps_url= "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_api_key}"
raw_response_maps = HTTP.get(google_maps_url)
parsed_response_maps = JSON.parse(raw_response_maps)

#pp parsed_response_maps.keys

latitude = parsed_response_maps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
longitude = parsed_response_maps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")


# Get the weather at the user’s coordinates from the Pirate Weather API.
pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"
raw_response_weather = HTTP.get(pirate_weather_url)
parsed_response_weather = JSON.parse(raw_response_weather)

current_temp=parsed_response_weather.fetch("currently").fetch("temperature")

# Display the current temperature and summary of the weather for the next hour.
puts "It is currently #{current_temp}°F."
