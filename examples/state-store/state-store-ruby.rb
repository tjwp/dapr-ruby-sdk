# frozen_string_literal: true

require "dapr-client"

$stdout.sync = true

client = Dapr::Client::GRPC.new

key = "my-key"
store_name = "statestore"
value = "my state"

client.save_state(store_name: store_name,
                  key: key,
                  value: value)
puts "Saved!"

response = client.get_state(store_name: store_name, key: key)
puts "Fetched!"
puts response.inspect

client.delete_state(store_name: store_name, key: key)
puts "Deleted!"

puts "Using state store"
value = "my state store"
store = client.state_store(store_name)

store[key] = value
puts "Saved!"

result = store[key]
puts "Fetched!"
puts result.inspect

store.delete(key)
puts "Deleted!"