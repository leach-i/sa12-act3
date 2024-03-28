require 'httparty'

def fetch_weather(api_key, city)
  url = "http://api.openweathermap.org/data/2.5/forecast?q=#{city}&appid=#{api_key}&units=metric"
  response = HTTParty.get(url)
  return JSON.parse(response.body)
end

def calculate_average_temperature(weather_data)
  if weather_data['cod'] == '200' && weather_data['list']
    temperatures = weather_data['list'].map { |hour| hour['main']['temp'] }
    total_temperature = temperatures.inject(0.0) { |sum, temp| sum + temp }
    return total_temperature / temperatures.size
  else
    return nil
  end
end

api_key = '988879785d02f70de804f3db700f8d81'

city = 'Memphis'

weather_data = fetch_weather(api_key, city)

if weather_data
  average_temperature = calculate_average_temperature(weather_data)

  if average_temperature
    puts "Average temperature in #{city}: #{average_temperature.round(2)}°C"
  else
    puts "Failed to calculate average temperature: Weather data structure is not as expected."
  end
else
  puts "Failed to fetch weather data: API response is empty."
end
