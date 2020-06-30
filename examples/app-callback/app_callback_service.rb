# frozen_string_literal: true

require "dapr/proto/runtime/v1/appcallback_services_pb"
require "json"

class AppCallbackService < Dapr::Proto::Runtime::V1::AppCallback::Service
  Any = Google::Protobuf::Any
  Protocol = Dapr::Proto::Runtime::V1

  def on_invoke(invoke, _call)
    puts "invoked!"
    # Be careful! method() is a builtin method in Ruby
    method = invoke['method']
    raw_data = invoke.data
    data = JSON.parse(raw_data.value) if raw_data&.value
    result = { method: method, data: data }
    Dapr::Proto::Common::V1::InvokeResponse.new(data: Any.new(value: result.to_json))
  rescue => ex
    Dapr::Proto::Common::V1::InvokeResponse.new(data: Any.new(value: { error: ex.inspect }.to_json))
  end

  def list_topic_subscriptions(_empty, _call)
    puts "topics requested!"
    Protocol::ListTopicSubscriptionsResponse.
        new(subscriptions: Array(Protocol::TopicSubscription.new(topic: "example")))
  end

  def list_input_bindings(_empty, _call)
    puts "bindings requested!"
    Protocol::ListInputBindingsResponse.new(bindings: %w(readers_digest))
  end

  def on_binding_event(binding_event, _call)
    puts "binding event!"
    name = binding_event.name
    raw_data = binding_event.data
    metadata = binding_event.metadata
    puts "Binding Event: name:#{name}, data: #{raw_data}"
    Protocol::BindingEventResponse.new # data: Any.new(value:)
  end

  def on_topic_event(topic_event, _call)
    puts "topic event!"
    topic = topic_event.topic
    raw_data = topic_event.data
    puts "Topic Event: topic:#{topic}, data: #{raw_data}"
    Google::Protobuf::Empty.new
  rescue => ex
    puts ex.inspect
  end
end
