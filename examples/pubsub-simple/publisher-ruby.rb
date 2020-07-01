# frozen_string_literal: true

require "dapr-client"

$stdout.sync = true

client = Dapr::Client::GRPC.new

client.publish_event(topic: "TOPIC_A", data: "ACTION=1")

puts "Published!"