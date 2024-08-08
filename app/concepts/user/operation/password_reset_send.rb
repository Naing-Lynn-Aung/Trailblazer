module User::Operation
  class PasswordResetSend < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: User::Contract::PasswordResetSend)
    end
    step Nested(Present)
    step Contract::Validate()
    step :find_email!
    step :send_password_reset!

    def find_email!(options, params:, **)
      options['user'] = User.find_by_email(params['email'])
    end

    def send_password_reset!(options, **)
      PasswordMailer.with(user: options['user']).reset.deliver_now
    end
  end
end
