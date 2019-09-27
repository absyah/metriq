# Metriq

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/metriq`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metriq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metriq

## Usage

Provide these environments variables:

```ruby
GOOGLE_PROJECT_ID: <your google project id>
GOOGLE_APPLICATION_CREDENTIALS: <static path of your google application creds file (json)>
METRIQ_REDIS_URL: <your redis url with port>
METRIQ_REDIS_DATABASE: <your redis database>
METRIQ_REDIS_NAMESPACE: <your redis namespace, default will be /metriq>
METRIQ_REDIS_PASSWORD: <your redis password, leave it blank if no password required>
```

On your code:

```ruby
metrics_key = 'my_key'

# create a metrics draft
data = {foo: 'bar'} # should be rails' hash
Metriq::Page.draft(metrics_key, data)
> OK

# get metrics draft
data = Metriq::Page.read(metrics_key)

# submit to publisher (BigQuery)
dataset = 'metrics' # your google bigquery dataset
table = 'item_action_metrics' # your bigquery table

Metricq::Page.new(dataset, table, data).publish

```

Errors class:

Currently it supports this error class:

```ruby
Metriq::Error::PublisherError
```
It provides what was wrong upon your insertion to Google BigQuery, for the example:

```
1 : [#<Google::Cloud::Bigquery::InsertResponse::InsertError:0x00007ffff5aed790 @index=0, @row={:queue_at=>"1"}, @errors=[{"debugInfo"=>"", "location"=>"queue_at", "message"=>"no such field.", "reason"=>"invalid"}]>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/metriq. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Metriq project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/metriq/blob/master/CODE_OF_CONDUCT.md).
