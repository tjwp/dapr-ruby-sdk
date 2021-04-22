# frozen_string_literal: true

require "dapr/test/fake_dapr_sidecar"

RSpec.describe "generated GRPC client" do
  let(:server) { FakeDaprSidecar.new }
  let(:port) { rand(10000..60000) }
  let(:server_port) { "0.0.0.0:#{port}" }
  let(:client) { Dapr::Proto::Runtime::V1::Dapr::Stub.new("localhost:#{port}", :this_channel_is_insecure) }

  before { server.start(port: server_port) }
  after { server.stop }

  describe "#invoke_service" do
    it "invokes the bytes method" do
      data = String.new("haha", encoding: "BINARY")
      content_type = "text/plain"
      request = Dapr::Proto::Runtime::V1::InvokeServiceRequest.new(
        id: "targetId",
        message: Dapr::Proto::Common::V1::InvokeRequest.new(
          method: "bytes",
          data: Google::Protobuf::Any.new(value: data),
          content_type: content_type,
          http_extension: Dapr::Proto::Common::V1::HTTPExtension.new(
            verb: :PUT
          )
        )
      )
      response = client.invoke_service(request, metadata: { k: "v" })

      expect(response.data.value).to eq(data)
      expect(response.content_type).to eq(content_type)
      # Note: unable to get headers/trailers
    end

    it "invokes the proto method" do
      key = "test"
      data = Dapr::Proto::Common::V1::StateItem.new(key: key).then { |v| v.class.encode(v) }
      request = Dapr::Proto::Runtime::V1::InvokeServiceRequest.new(
        id: "targetId",
        message: Dapr::Proto::Common::V1::InvokeRequest.new(
          method: "proto",
          data: Google::Protobuf::Any.new(value: data),
        )
      )

      response = client.invoke_service(request)
      state_item = Dapr::Proto::Common::V1::StateItem.decode(response.data.value)
      expect(state_item.key).to eq(key)
    end

    #    def test_invoke_method_proto_data(self):
    #         dapr = DaprGrpcClient(f'localhost:{self.server_port}')
    #         req = common_v1.StateItem(key='test')
    #         resp = dapr.invoke_method(
    #             app_id='targetId',
    #             method_name='proto',
    #             data=req,
    #             metadata=(
    #                 ('key1', 'value1'),
    #                 ('key2', 'value2'),
    #             ),
    #         )
    #
    #         self.assertEqual(3, len(resp.headers))
    #         self.assertEqual(['value1'], resp.headers['hkey1'])
    #         self.assertTrue(resp.is_proto())
    #
    #         # unpack to new protobuf object
    #         new_resp = common_v1.StateItem()
    #         resp.unpack(new_resp)
    #         self.assertEqual('test', new_resp.key)
  end
end