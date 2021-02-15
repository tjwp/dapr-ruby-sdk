# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: dapr/proto/runtime/v1/appcallback.proto for package 'dapr.proto.runtime.v1'
# Original file comments:
# ------------------------------------------------------------
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
# ------------------------------------------------------------
#

require 'grpc'
require 'dapr/proto/runtime/v1/appcallback_pb'

module Dapr
  module Proto
    module Runtime
      module V1
        module AppCallback
          # AppCallback V1 allows user application to interact with Dapr runtime.
          # User application needs to implement AppCallback service if it needs to
          # receive message from dapr runtime.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'dapr.proto.runtime.v1.AppCallback'

            # Invokes service method with InvokeRequest.
            rpc :OnInvoke, Dapr::Proto::Common::V1::InvokeRequest, Dapr::Proto::Common::V1::InvokeResponse
            # Lists all topics subscribed by this app.
            rpc :ListTopicSubscriptions, Google::Protobuf::Empty, ListTopicSubscriptionsResponse
            # Subscribes events from Pubsub
            rpc :OnTopicEvent, TopicEventRequest, TopicEventResponse
            # Lists all input bindings subscribed by this app.
            rpc :ListInputBindings, Google::Protobuf::Empty, ListInputBindingsResponse
            # Listens events from the input bindings
            #
            # User application can save the states or send the events to the output
            # bindings optionally by returning BindingEventResponse.
            rpc :OnBindingEvent, BindingEventRequest, BindingEventResponse
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
