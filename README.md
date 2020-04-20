# Dapr SDK for Ruby

This is the Dapr SDK for Ruby, based on the auto-generated proto client.<br>

For more info on Dapr and gRPC, visit [this link](https://github.com/dapr/docs/tree/master/howto/create-grpc-app).

The repository generates the following package
- dapr-client

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
require "dapr_services_pb"

client = Dapr::Dapr::Stub.new('localhost:5001', :this_channel_is_insecure)
```

You can find a complete example [here](https://github.com/tjwp/dapr-ruby-sdk/blob/master/example.rb)

### Running the code locally

You can execute this code using the local dapr runtime:

```sh
dapr run --protocol grpc --grpc-port=50001 ruby example.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tjwp/dapr-ruby-sdk.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
