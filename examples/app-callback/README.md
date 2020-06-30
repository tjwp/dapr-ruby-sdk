# AppCallbackExample

Run the example service:

```bash
dapr run --app-id app-callback --protocol grpc --app-port 50051 \
  bundle exec ruby app_callback_example.rb
```

Make a request to invoke a method:

```bash
dapr invoke -a app-callback -m foobar -p '{"foo": "bar"}'
```

Publish a message to a topic:

```bash
dapr publish -t "example" -d "5"
```