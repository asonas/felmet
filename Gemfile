ruby "2.4.1"
source "https://rubygems.org"

gem 'rails', '4.2.8'

gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 2.0'
gem 'kaminari'
gem 'pg'
gem 'puma'
gem 'rails_12factor'
gem 'rails_serve_static_assets'
gem 'rails_stdout_logging'
gem 'sass-rails', '~> 4.0.3'
gem "sentry-raven"
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'letter_opener_web', '~> 1.2.0', group: :test
  gem 'pry', group: :test
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'sqlite3', group: :test
end

group :test do
  gem 'database_rewinder'
  gem 'fabrication'
  gem 'faker'
  gem 'guard-rspec'
  gem 'konacha'
  gem "poltergeist"
  gem 'rspec-rails', group: :development
  gem 'timecop'
end

group :production do
  gem 'newrelic_rpm'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-fontawesome'
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-underscore'
end
