# frozen_string_literal: true

require "grpc"
require "dapr/test/test_handler"

class FakeDaprSidecar
  def initialize(handler: TestHandler.new)
    @handler = handler
    @server = GRPC::RpcServer.new
    @shutdown_received = false # TODO
  end

  def start(port: "0.0.0.0:50051")
    server.add_http2_port(port, :this_port_is_insecure)
    server.handle(handler)
    GRPC.logger.info("... running insecurely on #{port}")
    Thread.new do
      server.run_till_terminated_or_interrupted([1, +"int", +"SIGQUIT"])
    end
  end

  def stop
    server.stop if server.running?
  end

  private

  attr_reader :server, :handler, :shutdown_received
end
