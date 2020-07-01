# Example - Invoke

This example utilizes a receiver and a caller for the OnInvoke / Invoke
functionality. It will create a gRPC server and bind the on_invoke method,
which gets called after a client sends a direct method invocation.

## Running

To run this example, use the following code:

```
# 1. Start Receiver (expose gRPC receiver server on port 50051)
dapr run --app-id invoke-receiver --protocol grpc --app-port 50051 bundle exec ruby invoke-receiver.rb

# 2. Start Caller
dapr run --app-id invoke-caller --protocol grpc bundle exec ruby invoke-caller.rb
```

### Ruby client

To run the caller using the Ruby implementation:

```bash
dapr run --app-id invoke-caller-ruby --protocol grpc bundle exec ruby invoke-caller-ruby.rb
```