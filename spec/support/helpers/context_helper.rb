# frozen_string_literal: true

module ContextHelper
  module_function

  def random_email
    Faker::Internet.email
  end

  def random_password
    Faker::Internet.password
  end
end
