# frozen_string_literal: true

require "daprclient_services_pb"
require "json"

module Dapr
  class DaprClientImpl < Daprclient::DaprClient::Service
    Any = Google::Protobuf::Any

    def on_invoke(invoke, _call)
      puts "invoked!"
      # Be careful! method() is a builtin method in Ruby
      method = invoke['method']
      metadata = invoke.metadata
      raw_data = invoke.data
      data = JSON.parse(raw_data.value) if raw_data&.value
      result = { method: method, data: data }
      Any.new(value: result.to_json)
    rescue => ex
      Any.new(value: { error: ex.inspect }.to_json)
    end

    def get_topic_subscriptions(_empty, _call)
      puts "topics requested!"
      Daprclient::GetTopicSubscriptionsEnvelope.new(topics: %w(example))
    end

    def get_bindings_subscriptions(_empty, _call)
      puts "bindings requested!"
      Daprclient::GetBindingsSubscriptionsEnvelope.new(bindings: %w(readers_digest))
    end

    def on_binding_event(binding_event, _call)
      puts "binding event!"
      name = binding_event.name
      raw_data = binding_event.data&.value
      metadata = binding_event.metadata
      Daprclient::BindingResponseEnvelope.new # data: Any.new(value:)
    end

    def on_topic_event(cloud_event, _call)
      puts "topic event!"
      topic = cloud_event.topic
      raw_data = cloud_event.data&.value
      puts "Topic Event: topic:#{topic}, data: #{raw_data}"
      Google::Protobuf::Empty.new
    rescue => ex
      puts ex.inspect
    end
  end
end
