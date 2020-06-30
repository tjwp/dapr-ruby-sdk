# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

$stdout.sync = true

RuntimeV1 = Dapr::Proto::Runtime::V1

port = ENV["DAPR_GRPC_PORT"]
client = Dapr::Proto::Runtime::V1::Dapr::Stub.new("localhost:#{port}", :this_channel_is_insecure)

client.publish_event(RuntimeV1::PublishEventRequest.
    new(topic: "TOPIC_A", data: "ACTION=1"))

puts "Published!"
