# rdh/active_intelligence README

A Rails engine that provides Rails-y AI integration


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_intelligence', git: 'git@github.com:rdh/active_intelligence.git', branch: 'main'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_intelligence
```

## Usage

### 1. Configuration
Configure your LLM in `config/llm.yml`, something like:
```yaml
openai: &openai
  adapter: openai
  access_token: <%= ENV.fetch('OPENAI_ACCESS_TOKEN') %>
  organization_id: <%= ENV.fetch('OPENAI_ORGANIZATION_ID')  %>
  request_timeout: 120


development:
  <<: *openai
  model: gpt-4-32k
  temperature: 0.0
```

### 2. app/prompts

* Prompts live in `app/prompts`.  They are ERB files.
* The default prompt per-model is named after the model, e.g. `app/prompts/user.erb`
* Named prompts per-model live in a subdirectory named adter the model, e.g. `app/prompts/user/invite.erb`

### 3. include ActiveIntelligence::Promptable

Add `include ActiveIntelligence::Promptable` to your model, which adds the `#to_prompt` and `#from_llm` methods.

### 4.  Call `#from_llm` to generate a response

```ruby
default_response = user.from_llm 
invite_response = user.from_llm(:invite)
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
