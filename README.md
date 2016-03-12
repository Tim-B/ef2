# EF2: Elastic Fresh Formation

Eliminate the operational burden of supporting your household by automating the deployment
of your Amazon Fresh orders.

This gem provides a convenient Ruby DSL to model your ordering patterns, allowing you to
orchestrate your grocery shopping in a stateless and version controlled manner.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ef2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ef2

## Usage

You can find an example of a list and catalog under the `examples`` directory.

Example list:

```

recipe 'Bacon and Eggs'

product 'Toilet Paper' do
  quantity 5
  picker :random
end

product 'Ketchup' do
  picker :first
  every 6, :weeks
end
```

Running: `bin/ef2 form examples/basic_list.rb`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ef2.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

