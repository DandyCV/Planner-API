# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby(File.read(File.join(File.dirname(__FILE__), '.tool-versions')).match(/^ruby\s+([\d.]+)/)[1])

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~>7.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'
# Use Puma as the app server
gem 'puma', '~> 6.4'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Fast JSON:API serializer for Ruby Objects
gem 'jsonapi-serializer', '~> 2.2.0'
# Business transaction DSL
gem 'dry-transaction', '~> 0.16'
# Data validation library that provides a powerful DSL for defining schemas and validation rules
gem 'dry-validation', '~> 1.10'
# Ruby email validator
gem 'truemail', '~> 3.3'
# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard
gem 'jwt', '~> 2.8'
# A Ruby client library for Redis
gem 'redis', '~> 5.1'
# Simple, efficient background processing
gem 'sidekiq', '~> 7.3'
# Sessions based on JSON Web Tokens
gem 'jwt_sessions', '~> 3.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # RSpec testing framework
  gem 'rspec', '~> 3.13'
  # RSpec testing framework to Ruby on Rails
  gem 'rspec-rails', '~> 6.0'
  # Fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '~> 6.4'
  # Generates fake data
  gem 'faker', '~> 3.3'
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug
  gem 'pry-byebug', '~> 3.10'
  # Causes rails console to open pry
  gem 'pry-rails', '~> 0.3.9'

  # Code quality
  # Help you increase your application performance by reducing the number of queries it makes
  gem 'bullet', '~> 7.1'
  # Patch-level verification for bundler
  gem 'bundler-audit', '~> 0.9', require: false
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman', '~> 6.1', require: false
  # Code smell detector for Ruby
  gem 'reek', '6.3', require: false
  # Make your Rubies go faster with this command line tool
  gem 'fasterer', '~> 0.10', require: false
  # A fully configurable and extendable Git hook manager
  gem 'overcommit', '~> 0.63', require: false
  # Code metric tool to check the quality of Rails code
  gem 'rails_best_practices', '~> 1.23', require: false
  # A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', '~> 1.66', require: false
  gem 'rubocop-factory_bot', '~> 2.22', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rails', '~> 2.25', require: false
  gem 'rubocop-rspec', '~> 3.0', require: false
  gem 'rubocop-rspec_rails', '~> 2.22', require: false
end

group :development do
  gem 'letter_opener', '~> 1.10'
  gem 'listen', '~> 3.8'
end

group :test do
  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.22', require: false
  # Custom SimpleCov formatter to generate a lcov style coverage
  gem 'simplecov-lcov', '~> 0.8', require: false
  # Validate the JSON returned by your Rails JSON APIs
  gem 'json_matchers', '~> 0.11', require: 'json_matchers/rspec'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 5.2'
  # Inspects files in a git diff and warns on changed methods, classes and blocks which need to be tested
  gem 'undercover', '~> 0.6', require: false
  # Simple testing of Sidekiq jobs via a collection of matchers and helpers
  gem 'rspec-sidekiq', '~> 5.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]
