# frozen_string_literal: true

$stdout.sync = true

require "dapr/proto/runtime/v1/appcallback_services_pb"

class InvokeReceiverService < Dapr::Proto::Runtime::V1::AppCallback::Service
  Any = Google::Protobuf::Any

  def on_invoke(invoke, _call)
    content_type = "text/plain; charset=UTF-8"
    puts "Invoked method '#{invoke["method"]}' with value '#{invoke["data"]["value"]}'"
    data = if invoke["method"] == "my-method"
             Any.new(value: "INVOKE_RECEIVED")
           else
             Any.new(value: "unsupported method")
           end

    Dapr::Proto::Common::V1::InvokeResponse.new(data: data, content_type: content_type)
  end
end

server = GRPC::RpcServer.new
server.add_http2_port("0.0.0.0:50051", :this_port_is_insecure)
server.handle(InvokeReceiverService)

server.run_till_terminated_or_interrupted([1, +"int", +"SIGQUIT"])