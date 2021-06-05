# frozen_string_literal: true

# module Api::V1::Users::Registrations::Operation
#   class Create
#     include Dry::Transaction::Operation

#     def call(params)
#       user = User.create!(params[:email], params[:password]))
#       Success(user)
#       Failure(user.errors)
#     end
#   end
# end
