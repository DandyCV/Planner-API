# frozen_string_literal: true

module ContextHelper
  module_function

  def random_email
    Faker::Internet.email
  end

  def random_password
    Faker::Internet.password
  end

  def random_token
    Faker::Internet.password(min_length: 55, max_length: 80)
  end

  def random_path
    Faker::Internet.url(host: 'example.com')
  end
end
