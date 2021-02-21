# AppCallbackExample

Run the example service:

```bash
dapr run --app-id app-callback --app-protocol grpc --app-port 50051 \
  -- bundle exec ruby app_callback_example.rb
```

Make a request to invoke a method:

```bash
dapr invoke --app-id app-callback --method foobar --data '{"foo": "bar"}'
```

Publish a message to a topic:

```bash
dapr publish -i app-callback --pubsub pubsub --topic "example" --data "5"
```

Invoke the binding:
```ruby
dapr run --app-id invoke-binding -- bundle exec ruby invoke-binding.rb
```