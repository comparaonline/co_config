# CoConfig

This is a simple gem to load configuration files on rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'co_config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install co_config

## Usage

Create a `configuration.rb` file on your rails application's config folder.
This file will indicate which files are loaded.

```ruby
# To load the test.yml file into the CoConfig::TEST hash
load 'test' 

# To validate the configuration you could use
load 'test2' { |c| c.token.present? } 
# or
load 'test3' { |c| raise if token.empty? }
```

YAML files must have a root key called like the current `Rails.env`. A key called `defaults` can be used to specify defaults for undefined environments.

```yaml
# test.yml
---

development:
   value: 1
```

```yaml
# test2.yml
---

defaults:
   token: 'MYAWESOMETOKEN'
```

To read your configuration you can access the hash (with indifferent access) at `CoConfig::CONFIG_NAME_UPPERCASE`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/co_config.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

