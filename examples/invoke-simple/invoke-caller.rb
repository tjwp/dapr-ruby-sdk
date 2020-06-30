# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

$stdout.sync = true

port = ENV["DAPR_GRPC_PORT"]
stub = Dapr::Proto::Runtime::V1::Dapr::Stub.new("localhost:#{port}", :this_channel_is_insecure)
request = Dapr::Proto::Runtime::V1::InvokeServiceRequest.
    new(id: "invoke-receiver",
        message: Dapr::Proto::Common::V1::InvokeRequest.new(
          method: "my-method",
          data: Google::Protobuf::Any.new(value: "TEST MESSAGE"),
          content_type: "text/plain; charset=UTF-8"
        ))
response = stub.invoke_service(request)

puts response.content_type
puts response.data.value