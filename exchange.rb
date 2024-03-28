require 'httparty'

def fetch_exchange_rate(api_key)
  url = "https://v6.exchangerate-api.com/v6/#{api_key}/latest/USD"
  response = HTTParty.get(url)
  data = JSON.parse(response.body)
  if data['result'] == 'success'
    return data['conversion_rates']['SGD']
  else
    puts "Error: #{data['error']}"
    return nil
  end
end

def convert_to_sgd(api_key, amount)
  exchange_rate = fetch_exchange_rate(api_key)
  if exchange_rate
    converted_amount = amount * exchange_rate
    return converted_amount
  else
    return nil
  end
end

api_key = '3e188cb17010067e888bd06d'

amount_usd = 100

converted_amount_sgd = convert_to_sgd(api_key, amount_usd)

if converted_amount_sgd
  puts "#{amount_usd} USD is equivalent to #{converted_amount_sgd.round(2)} SGD"
else
  puts "Failed to convert currency. Please check your API key and try again."
end
