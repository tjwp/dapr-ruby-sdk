# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

port = ENV.fetch('DAPR_GRPC_PORT', '5001')
dapr_uri = "localhost:#{port}"

client = Dapr::Proto::Runtime::V1::Dapr::Stub.new(dapr_uri, :this_channel_is_insecure)
data = 'lala'
client.publish_event(Dapr::Proto::Runtime::V1::PublishEventRequest.new(pubsub_name: 'pubsub', topic: 'sith', data: 'lala'))
puts('Published')

key = 'mykey'
store_name = 'statestore'
state = Dapr::Proto::Common::V1::StateItem.new(key: key, value: 'my state')
req = Dapr::Proto::Runtime::V1::SaveStateRequest.new(store_name: store_name, states: [state])
client.save_state(req)
puts('Saved!')

resp = client.get_state(Dapr::Proto::Runtime::V1::GetStateRequest.new(store_name: store_name, key: key))
puts('Got state!')
puts(resp)

client.delete_state(Dapr::Proto::Runtime::V1::DeleteStateRequest.new(store_name: store_name, key: key))
puts('Deleted!')
