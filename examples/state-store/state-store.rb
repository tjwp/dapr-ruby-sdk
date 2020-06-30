# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

$stdout.sync = true

RuntimeV1 = Dapr::Proto::Runtime::V1

port = ENV["DAPR_GRPC_PORT"]
client = Dapr::Proto::Runtime::V1::Dapr::Stub.new("localhost:#{port}", :this_channel_is_insecure)

key = "my-key"
store_name = "statestore"

state = Dapr::Proto::Common::V1::StateItem.
    new(key: key, value: "my state")

client.save_state(RuntimeV1::SaveStateRequest.
    new(store_name: store_name, states: Array(state)))
puts "Saved!"

response = client.get_state(RuntimeV1::GetStateRequest.
    new(store_name: store_name, key: key))
puts "Fetched!"
puts response.inspect

client.delete_state(RuntimeV1::DeleteStateRequest.
    new(store_name: store_name, key: key))
puts "Deleted!"
