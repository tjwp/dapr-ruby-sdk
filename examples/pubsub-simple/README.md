# Example - Pub/Sub

## Running

To run this example, use the following commands:

```bash
# 1. Start Subscriber (expose gRPC receiver server on port 50051)
dapr run --app-id subscriber --protocol grpc --app-port 50051 bundle exec ruby subscriber.rb

# 2. Start Publisher
dapr run --app-id publisher --protocol grpc bundle exec ruby publisher.rb
```

### Ruby client

Alternatively to publish using the ruby client

```bash
dapr run --app-id publisher-ruby --protocol grpc bundle exec ruby publisher-ruby.rb
```