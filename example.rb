# frozen_string_literal: true

require "dapr_services_pb"

port = ENV.fetch('DAPR_GRPC_PORT', '5001')
dapr_uri = "localhost:#{port}"

client = Dapr::Dapr::Stub.new(dapr_uri, :this_channel_is_insecure)
data = Google::Protobuf::Any.new(value: 'lala')
client.publish_event(Dapr::PublishEventEnvelope.new(topic: 'sith', data: data))
puts('Published')

key = 'mykey'
store_name = 'statestore'
req = Dapr::StateRequest.new(key: key, value: Google::Protobuf::Any.new(value: 'my state'))
state = Dapr::SaveStateEnvelope.new(storeName: store_name, requests: [req])
client.save_state(state)
puts('Saved!')

resp = client.get_state(Dapr::GetStateEnvelope.new(storeName: store_name, key: key))
puts('Got state!')
puts(resp)

client.delete_state(Dapr::DeleteStateEnvelope.new(storeName: store_name, key: key))
puts('Deleted!')
