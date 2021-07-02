# frozen_string_literal: true

Truemail.configure do |config|
  config.verifier_email = Constants::Shared::VERIFIER_EMAIL
  config.default_validation_type = :regex
end
