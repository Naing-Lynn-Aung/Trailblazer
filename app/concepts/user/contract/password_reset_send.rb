require 'reform/form/validation/unique_validator'
module User::Contract
  class PasswordResetSend < Reform::Form
    property :email

    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VAILD_EMAIL_REGEX }
  end
end
