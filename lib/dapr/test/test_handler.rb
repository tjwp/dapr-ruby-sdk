# frozen_string_literal: true

require "dapr/proto/runtime/v1/dapr_services_pb"

class TestHandler < Dapr::Proto::Runtime::V1::Dapr::Service
  Any = Google::Protobuf::Any
  Common = Dapr::Proto::Common::V1

  def invoke_service(request, call)
    content_type = ""
    response_data = Any.new

    with_headers_and_trailers(call) do
      if request.message["method"] == "bytes"
        response_data.value = request.message.data.value
        content_type = request.message.content_type
      else
        response_data = request.message.data
      end
    end

    Common::InvokeResponse.new(data: response_data, content_type: content_type)
  end

  private

  def with_headers_and_trailers(call)
    headers = {}
    trailers = { }

    call.metadata.each do |key, value|
      headers["h#{key}"] = value
      trailers["t#{key}"] = value
    end

    yield

    call.send_initial_metadata(headers)
    call.output_metadata.merge(trailers)
  end
end
