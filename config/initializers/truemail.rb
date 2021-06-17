# frozen_string_literal: true

Truemail.configure do |config|
  config.verifier_email = 'verifier@example.com'
  config.default_validation_type = :regex
end