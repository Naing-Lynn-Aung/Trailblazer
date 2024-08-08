module User::Operation
  class ResetPassword < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: User::Contract::ResetPassword)

      def model!(options, params:, **)
        options['model'] = User.find_signed!(params['token'], purpose: 'password_reset')
        rescue ActiveSupport::MessageVerifier::InvalidSignature
      end
    end
    step Nested(Present)
    step Contract::Validate(key: :user)
    step Contract::Persist()
    # step :generate_password!

    def generate_password!(options, model:, **)
      model.user.password_digest = BCrypt::Password.create(params[:password])
      model.user.save()
    end
  end
end
