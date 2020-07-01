# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

module Dapr
  module Client
    class GRPC
      Any = Google::Protobuf::Any
      RuntimeV1 = Dapr::Proto::Runtime::V1
      CommonV1 = Dapr::Proto::Common::V1
      EMPTY_HASH= Hash.new.freeze

      JSON_CONTENT_TYPE = "application/json"

      class StateStore
        attr_reader :name, :client

        def initialize(name:, client:)
          @name = name
          @client = client
        end

        def [](key)
          value, _etag = client.get_state(store_name: name, key: key)
          value
        end

        def []=(key, value)
          # TODO: support save item?
          client.save_state(store_name: name, key: key, value: value)
          value
        end

        def delete(key)
          client.delete_state(store_name: name, key: key)
          nil
        end

        def merge(data)
          client.save_states(store_name: name, data: data)
          nil
        end
      end

      def initialize(port: nil)
        port ||= "localhost:#{ENV['DAPR_GRPC_PORT']}"
        @stub = RuntimeV1::Dapr::Stub.new(port, :this_channel_is_insecure)
      end

      def invoke_service(app_id:, method:, data: nil, content_type: JSON_CONTENT_TYPE)
        request = RuntimeV1::InvokeServiceRequest.new(
          id: app_id,
          message: CommonV1::InvokeRequest.new(
            {
              method: method,
              data: data.nil? ? data : Any.new(value: data),
              content_type: content_type
            }.compact)
        )
        response = stub.invoke_service(request)

        [response.data&.value, response.content_type]
      end

      def publish_event(topic:, data:)
        stub.publish_event(RuntimeV1::PublishEventRequest.new(
          topic: topic, data: data
        ))
        nil
      end

      def state_store(name)
        StateStore.new(name: name, client: self)
      end

      def save_state(store_name:, key:, value:, etag: nil, metadata: EMPTY_HASH, options: EMPTY_HASH)
        stub.save_state(RuntimeV1::SaveStateRequest.new(
          store_name: store_name,
          states: Array(CommonV1::StateItem.new(
            {
              key: key,
              value: value,
              etag: etag,
              metadata: metadata,
              options: CommonV1::StateOptions.new(options)
            }.compact
          ))
        ))
        nil
      end

      def save_states(store_name:, data:)
        # TODO: support array of state items as data?
        stub.save_state(RuntimeV1::SaveStateRequest.new(
          store_name: store_name,
          states: data.map do |key, value|
            # TODO: support state items?
            CommonV1::StateItem.new(key: key, value: value)
          end
        ))
        nil
      end

      def get_state(store_name:, key:, consistency: nil)
        response = stub.get_state(RuntimeV1::GetStateRequest.new(
          {
            store_name: store_name,
            key: key,
            consistency: consistency
          }.compact
        ))
        [response.data, response.etag]
      end

      def delete_state(store_name:, key:, etag: nil, options: EMPTY_HASH)
        stub.delete_state(RuntimeV1::DeleteStateRequest.new(
          {
            store_name: store_name,
            key: key,
            etag: etag,
            options: CommonV1::StateOptions.new(options)
          }.compact
        ))
        nil
      end

      def get_secret(store_name:, key:, metadata: EMPTY_HASH)
        response = stub.get_secret(RuntimeV1::GetSecretRequest.new(
          {
            store_name: store_name,
            key: key,
            metadata: metadata
          }
        ))
        response.data
      end

      def invoke_binding(name:, data:, metadata: EMPTY_HASH, operation: "create")
        # TODO: convert data to JSON?
        response = stub.invoke_binding(RuntimeV1::InvokeBindingRequest.new(
          {
            name: name,
            data: data,
            metadata: metadata,
            operation: operation
          }.compact
        ))
        [response.data, response.metadata]
      end

      private

      attr_reader :stub
    end
  end
end