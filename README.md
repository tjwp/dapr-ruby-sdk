# Dapr SDK for Ruby

This is a Dapr SDK for Ruby, based on the auto-generated proto client.<br>

For more infomation on Dapr and gRPC see the [getting started guides](https://docs.dapr.io/getting-started/).

The repository generates the following package
- dapr-client

## Supported Versions

The auto-generated proto client and the examples is this repo are based on Dapr v1.1.1.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dapr-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dapr-client

## Example Code

A client can be created as follows:

```ruby
require "dapr/proto/runtime/v1/dapr_services_pb"

client = Dapr::Proto::Runtime::V1::Dapr::Stub.new("localhost:#{ENV['DAPR_GRPC_PORT']}", :this_channel_is_insecure)
```

You can find a complete example [here](https://github.com/tjwp/dapr-ruby-sdk/blob/master/example.rb)

### Running the example code locally

You can execute this code using the local dapr runtime:

```sh
dapr run --app-id ruby-example -- bundle exec ruby example.rb
```

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

### GRPC Client

Protobuf definitions are stored in the `dapr/proto` directory of this repo.

There is a script, `bin/regen_client.sh`, that can be used to regenerate the Ruby client
from the protocol definitions. The generated code can be found in `lib/dapr/proto` and is
added to the lib path.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tjwp/dapr-ruby-sdk.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
