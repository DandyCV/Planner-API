# frozen_string_literal: true

require 'rspec-sidekiq'
require 'sidekiq/testing'

# Ensure jobs are performed immediately during specs and silence warnings
Sidekiq::Testing.inline!
