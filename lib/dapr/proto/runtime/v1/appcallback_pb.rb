# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: dapr/proto/runtime/v1/appcallback.proto

require 'google/protobuf'

require 'google/protobuf/empty_pb'
require 'dapr/proto/common/v1/common_pb'
require 'google/protobuf/struct_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("dapr/proto/runtime/v1/appcallback.proto", :syntax => :proto3) do
    add_message "dapr.proto.runtime.v1.TopicEventRequest" do
      optional :id, :string, 1
      optional :source, :string, 2
      optional :type, :string, 3
      optional :spec_version, :string, 4
      optional :data_content_type, :string, 5
      optional :data, :bytes, 7
      optional :topic, :string, 6
      optional :pubsub_name, :string, 8
      optional :path, :string, 9
      optional :extensions, :message, 10, "google.protobuf.Struct"
    end
    add_message "dapr.proto.runtime.v1.TopicEventResponse" do
      optional :status, :enum, 1, "dapr.proto.runtime.v1.TopicEventResponse.TopicEventResponseStatus"
    end
    add_enum "dapr.proto.runtime.v1.TopicEventResponse.TopicEventResponseStatus" do
      value :SUCCESS, 0
      value :RETRY, 1
      value :DROP, 2
    end
    add_message "dapr.proto.runtime.v1.TopicEventCERequest" do
      optional :id, :string, 1
      optional :source, :string, 2
      optional :type, :string, 3
      optional :spec_version, :string, 4
      optional :data_content_type, :string, 5
      optional :data, :bytes, 6
      optional :extensions, :message, 7, "google.protobuf.Struct"
    end
    add_message "dapr.proto.runtime.v1.TopicEventBulkRequestEntry" do
      optional :entry_id, :string, 1
      optional :content_type, :string, 4
      map :metadata, :string, :string, 5
      oneof :event do
        optional :bytes, :bytes, 2
        optional :cloud_event, :message, 3, "dapr.proto.runtime.v1.TopicEventCERequest"
      end
    end
    add_message "dapr.proto.runtime.v1.TopicEventBulkRequest" do
      optional :id, :string, 1
      repeated :entries, :message, 2, "dapr.proto.runtime.v1.TopicEventBulkRequestEntry"
      map :metadata, :string, :string, 3
      optional :topic, :string, 4
      optional :pubsub_name, :string, 5
      optional :type, :string, 6
      optional :path, :string, 7
    end
    add_message "dapr.proto.runtime.v1.TopicEventBulkResponseEntry" do
      optional :entry_id, :string, 1
      optional :status, :enum, 2, "dapr.proto.runtime.v1.TopicEventResponse.TopicEventResponseStatus"
    end
    add_message "dapr.proto.runtime.v1.TopicEventBulkResponse" do
      repeated :statuses, :message, 1, "dapr.proto.runtime.v1.TopicEventBulkResponseEntry"
    end
    add_message "dapr.proto.runtime.v1.BindingEventRequest" do
      optional :name, :string, 1
      optional :data, :bytes, 2
      map :metadata, :string, :string, 3
    end
    add_message "dapr.proto.runtime.v1.BindingEventResponse" do
      optional :store_name, :string, 1
      repeated :states, :message, 2, "dapr.proto.common.v1.StateItem"
      repeated :to, :string, 3
      optional :data, :bytes, 4
      optional :concurrency, :enum, 5, "dapr.proto.runtime.v1.BindingEventResponse.BindingEventConcurrency"
    end
    add_enum "dapr.proto.runtime.v1.BindingEventResponse.BindingEventConcurrency" do
      value :SEQUENTIAL, 0
      value :PARALLEL, 1
    end
    add_message "dapr.proto.runtime.v1.ListTopicSubscriptionsResponse" do
      repeated :subscriptions, :message, 1, "dapr.proto.runtime.v1.TopicSubscription"
    end
    add_message "dapr.proto.runtime.v1.TopicSubscription" do
      optional :pubsub_name, :string, 1
      optional :topic, :string, 2
      map :metadata, :string, :string, 3
      optional :routes, :message, 5, "dapr.proto.runtime.v1.TopicRoutes"
      optional :dead_letter_topic, :string, 6
      optional :bulk_subscribe, :message, 7, "dapr.proto.runtime.v1.BulkSubscribeConfig"
    end
    add_message "dapr.proto.runtime.v1.TopicRoutes" do
      repeated :rules, :message, 1, "dapr.proto.runtime.v1.TopicRule"
      optional :default, :string, 2
    end
    add_message "dapr.proto.runtime.v1.TopicRule" do
      optional :match, :string, 1
      optional :path, :string, 2
    end
    add_message "dapr.proto.runtime.v1.BulkSubscribeConfig" do
      optional :enabled, :bool, 1
      optional :max_messages_count, :int32, 2
      optional :max_await_duration_ms, :int32, 3
    end
    add_message "dapr.proto.runtime.v1.ListInputBindingsResponse" do
      repeated :bindings, :string, 1
    end
    add_message "dapr.proto.runtime.v1.HealthCheckResponse" do
    end
  end
end

module Dapr
  module Proto
    module Runtime
      module V1
        TopicEventRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventRequest").msgclass
        TopicEventResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventResponse").msgclass
        TopicEventResponse::TopicEventResponseStatus = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventResponse.TopicEventResponseStatus").enummodule
        TopicEventCERequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventCERequest").msgclass
        TopicEventBulkRequestEntry = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventBulkRequestEntry").msgclass
        TopicEventBulkRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventBulkRequest").msgclass
        TopicEventBulkResponseEntry = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventBulkResponseEntry").msgclass
        TopicEventBulkResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicEventBulkResponse").msgclass
        BindingEventRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.BindingEventRequest").msgclass
        BindingEventResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.BindingEventResponse").msgclass
        BindingEventResponse::BindingEventConcurrency = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.BindingEventResponse.BindingEventConcurrency").enummodule
        ListTopicSubscriptionsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.ListTopicSubscriptionsResponse").msgclass
        TopicSubscription = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicSubscription").msgclass
        TopicRoutes = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicRoutes").msgclass
        TopicRule = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.TopicRule").msgclass
        BulkSubscribeConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.BulkSubscribeConfig").msgclass
        ListInputBindingsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.ListInputBindingsResponse").msgclass
        HealthCheckResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("dapr.proto.runtime.v1.HealthCheckResponse").msgclass
      end
    end
  end
end
