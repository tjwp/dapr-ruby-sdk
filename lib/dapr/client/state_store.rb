# frozen_string_literal: true

module Dapr
  module Client
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
  end
end