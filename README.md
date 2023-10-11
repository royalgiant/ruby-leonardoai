# Ruby LeonardoAI

[![Gem Version](https://badge.fury.io/rb/ruby-openai.svg)](https://badge.fury.io/rb/ruby-leonardoai)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/royalgiant/ruby-leonardoai/blob/main/LICENSE.txt)

Use the [LeonardoAI API](https://docs.leonardo.ai/reference/getuserself) with Ruby! 🤖❤️

Generate, Get, and Delete images, models, variations, and datasets with Leonardo AI

🚢 Based in the US and want to hire me? Now you can! [Email Me](mailto:donaldlee50@gmail.com)

[🐦 Twitter](https://twitter.com/donaldlee50) | [▶️ Youtube](https://youtube.com/c/donaldleecrypto) 

### Bundler

Add this line to your application's Gemfile:

```ruby
gem "ruby-leonardoai"
```

And then execute:

```bash
$ bundle install
```

### Gem install

Or install with:

```bash
$ gem install ruby-leonardoai
```

and require with:

```ruby
require "leonardoai"
```

## Usage

- Get your API access from [https://app.leonardo.ai/api-access](https://app.leonardo.ai/api-access)
- After subscribing, you will be able to generate an api key from [https://app.leonardo.ai/settings](https://app.leonardo.ai/settings)

### Quickstart

For a quick test you can pass your token directly to a new client:

```ruby
client = LeonardoAI::Client.new(access_token: "access_token_goes_here")
```

### With Config

For a more robust setup, you can configure the gem with your API keys, for example in an `leonardoai.rb` initializer file. Never hardcode secrets into your codebase - instead use something like [dotenv](https://github.com/motdotla/dotenv) to pass the keys safely into your environments.

```ruby
LeonardoAI.configure do |config|
    config.access_token = ENV.fetch("LEONARDOAI_ACCESS_TOKEN")
end
```
If you use Rails 7, you would probably store your key in credentials.yml, then you can do something like this:
```ruby
LeonardoAI.configure do |config|
    config.access_token = Rails.application.credentials[Rails.env.to_sym].dig(:leonardoai, :api_key)
end
```

Then you can create a client like this:

```ruby
client = LeonardoAI::Client.new
```

You can still override the config defaults when making new clients; any options not included will fall back to any global config set with LeonardoAI.configure. e.g. in this example the uri_base, request_timeout, etc. will fallback to any set globally using LeonardoAI.configure, with only the access_token overridden:

```ruby
client = LeonardoAI::Client.new(access_token: "access_token_goes_here")
```

#### Custom timeout or base URI

The default timeout for any request using this library is 120 seconds. You can change that by passing a number of seconds to the `request_timeout` when initializing the client. You can also change the base URI used for all requests.

```ruby
client = LeonardoAI::Client.new(
    access_token: "access_token_goes_here",
    uri_base: "https://cloud.leonardo.ai/api/rest/v1/",
    request_timeout: 240,
    extra_headers: {
      "accept" => "application/json",
      "content-type": "application/json",
    }
)
```

or when configuring the gem:

```ruby
LeonardoAI.configure do |config|
    config.access_token = ENV.fetch("LEONARDOAI_ACCESS_TOKEN") # Or Rails.application.credentials[Rails.env.to_sym].dig(:leonardoai, :api_key) for Rails 7
    config.uri_base = "https://cloud.leonardo.ai/api/rest/v1/",
    config.request_timeout = 240 # Optional
    config.extra_headers = {
      "accept" => "application/json",
      "content-type": "application/json",
    } # Optional
end
```

### Generation

ChatGPT is a model that can be used to generate text in a conversational style. You can use it to [generate a response](https://platform.openai.com/docs/api-reference/chat/create) to a sequence of [messages](https://platform.openai.com/docs/guides/chat/introduction):

```ruby
params = {
    :height=>1024, 
    :prompt=>"A ad flyer of a ninja cat, heavy texture, moonlit background, circle design, tshirt design, pen and ink style", 
    :width=>512, :num_images=>1, 
    :photoReal=>false, 
    :presetStyle=>"LEONARDO", 
    :promptMagic=>true, 
    :promptMagicVersion=>"v2", 
    :public=>false, 
    :init_strength=>0.4, 
    :sd_version=>"v2", 
}

response = client.generations.generate(parameters: params) # {"sdGenerationJob"=>{"generationId"=>"c747522c-91e7-4830-8d1f-1f1ed37efd35"}}
puts response.dig("sdGenerationJob", "generationId")
# => "c747522c-91e7-4830-8d1f-1f1ed37efd35"
```

### Model
UNDER CONSTRUCTION

### Unzoom
UNDER CONSTRUCTION

### Dataset
UNDER CONSTRUCTION

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Warning

If you have an `LEONARDOAI_ACCESS_TOKEN` in your `ENV`, running the specs will use this to run the specs against the actual API, which will be slow and cost you money - 2 cents or more! Remove it from your environment with `unset` or similar if you just want to run the specs against the stored VCR responses.

## Release

First run the specs without VCR so they actually hit the API. This will cost 2 cents or more. Set LEONARDOAI_ACCESS_TOKEN in your environment or pass it in like this:

```
LEONARDOAI_ACCESS_TOKEN=123abc bundle exec rspec
```

Then update the version number in `version.rb`, update `CHANGELOG.md`, run `bundle install` to update Gemfile.lock, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/royalgiant/ruby-leonardoai>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/royalgiant/ruby-leonardoai/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby LeonardoAI project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/royalgiant/ruby-leonardoai/blob/main/CODE_OF_CONDUCT.md).

## Influences
Project heavily influenced by [https://github.com/alexrudall/ruby-openai](https://github.com/alexrudall/ruby-openai). Great project, go give them a star!