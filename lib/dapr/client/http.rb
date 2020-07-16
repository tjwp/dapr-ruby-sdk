# frozen_string_literal: true

require "faraday"
require "dapr/client/state_store"

module Dapr
  module Client
    class HTTP
      JSON_CONTENT_TYPE = "application/json"
      EMPTY_HASH= Hash.new.freeze

      def initialize(port: nil)
        port ||= "localhost:#{ENV['DAPR_GRPC_PORT']}"
        @conn = Faraday.new(port)
      end

      def invoke_service(app_id:, method:, data: nil, content_type: JSON_CONTENT_TYPE)
        path = "/v1.0/invoke/#{app_id}/method/#{method}"
        response = if data
          conn.post(path, data, "Content-Type" => content_type)
        else
          conn.post(path)
        end
        response.body
      end

      def publish_event(topic:, data:)
        _response = conn.post("/v1.0/publish#{topic}", data, 'Content-Type' => JSON_CONTENT_TYPE)
        nil
      end

      def state_store(name)
        StateStore.new(name: name, client: self)
      end

      def save_state(store_name:, key:, value:, etag: nil, metadata: EMPTY_HASH, options: EMPTY_HASH)
        _response = conn.post("/v1.0/state/#{store_name}",
                              ([{
                                key: key,
                                value: value,
                                etag: etag,
                                options: options
                              }.compact] +
                                metadata.map { |k, v| { key: k, value: v }.merge(options) }).to_json,
                              "Content-Type" => JSON_CONTENT_TYPE)
        nil
      end

      def save_states(store_name:, data:)
        _response = conn.post("/v1.0/state/#{store_name}",
                              data.map do |key, value|
                                { key: key, value: value }
                              end.to_json,
                              "Content-Type" => JSON_CONTENT_TYPE)
        nil
      end

      def get_state(store_name:, key:, consistency: nil)
        result = conn.get("/v1.0/state/#{store_name}/#{key}",
                          { consistency: consistency }.compact,
                          "Content-Type" => JSON_CONTENT_TYPE)
        result.body
      end

      def delete_state(store_name:, key:, etag: nil, options: EMPTY_HASH)
        conn.delete("/v1.0/state/#{store_name}/#{key}",
                    options,
                    { "If-Match" => etag }.compact)
      end

      def get_secret(store_name:, key:, metadata: EMPTY_HASH)
        result = conn.get("/v1.0/secrets/#{store_name}/#{key}",
                 metadata,
                 "Content-Type" => JSON_CONTENT_TYPE)
        response.body # TODO: parse JSON?
      end

      def invoke_binding(name:, data:, metadata: EMPTY_HASH, operation: 'create')
        result = conn.post("/v1.0/bindings/#{name}",
                           {
                             data: data,
                             operation: operation
                           }.merge(metadata),
                           "Content-Type" => JSON_CONTENT_TYPE)
      end

      private

      attr_reader :conn
    end
  end
end