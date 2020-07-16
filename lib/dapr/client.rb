# frozen_string_literal: true

require "dapr/client/grpc"
require "dapr/client/http"

module Dapr
  module Client
    class << self
      def grpc(port: nil)
        GRPC.new(port: port)
      end

      def http(port: nil)
        HTTP.new(port: port)
      end
    end
  end
end