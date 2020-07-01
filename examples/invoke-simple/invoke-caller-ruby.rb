# frozen_string_literal: true

require "dapr-client"

$stdout.sync = true

client = Dapr::Client::GRPC.new

response = client.invoke_service(app_id: "invoke-receiver",
                                 method: "my-method",
                                 data: "Test Message",
                                 content_type: "text/plain")

puts response.inspect