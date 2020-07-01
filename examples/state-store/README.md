# Example - State Store

This example demonstrates saving, fetching, and deleting state from the store.

## Running

To run this example use the following commands:

### GRPC

```bash
dapr run --app-id state-store --protocol grpc bundle exec ruby state-store.rb
```

### Ruby client

```bash
dapr run --app-id state-store-ruby --protocol grpc bundle exec ruby state-store-ruby.rb
```