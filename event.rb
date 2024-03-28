require 'httparty'

def fetch_events(api_key, location)
  url = "https://www.eventbriteapi.com/v3/users/me/?token=#{api_key}"
  response = HTTParty.get(url)
  data = JSON.parse(response.body)
  if response.success? && data['events']
    return data['events']
  else
    puts "Failed to fetch events: #{data['error_description']}"
    return []
  end
end

def display_events(events)
  if events.empty?
    puts "No upcoming events found."
  else
    events.each do |event|
      name = event['name']['text']
      venue = event['venue']['name']
      start_time = event['start']['local']
      puts "Name: #{name}"
      puts "Venue: #{venue}"
      puts "Start Time: #{start_time}"
      puts "---------------------"
    end
  end
end

api_key = 'C2W2EHN3YA7TRDYXQZZR'

location = 'Memphis, TN'

events = fetch_events(api_key, location)

puts "Upcoming events in #{location}:"
display_events(events)
