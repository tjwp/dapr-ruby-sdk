# frozen_string_literal: true

require "dapr/proto/runtime/v1/appcallback_services_pb"

$stdout.sync = true

class Subscriber < Dapr::Proto::Runtime::V1::AppCallback::Service
  RuntimeV1 = Dapr::Proto::Runtime::V1


  # Dapr will call this method to get the list of topics the app
  # wants to subscribe to. In this example, we are telling Dapr
  # To subscribe to a topic named TOPIC_A
  def list_topic_subscriptions(_empty, _call)
    # Name of the configured pubsub component
    pubsub_name = "pubsub"

    RuntimeV1::ListTopicSubscriptionsResponse.new(
        subscriptions: Array(RuntimeV1::TopicSubscription.new(pubsub_name: pubsub_name, topic: "TOPIC_A")))
  end

  def on_topic_event(topic_event, _call)
    puts "Event received #{topic_event}!"
    Google::Protobuf::Empty.new
  end
end

server = GRPC::RpcServer.new
server.add_http2_port("0.0.0.0:50051", :this_port_is_insecure)
server.handle(Subscriber)

server.run_till_terminated_or_interrupted([1, +"int", +"SIGQUIT"])