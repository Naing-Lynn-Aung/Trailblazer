require 'reform/form/validation/unique_validator'
module User::Contract
  class UpdateProfile < Reform::Form
    include Sync::SkipUnchanged
    property :name
    property :email
    property :phone
    property :user_type
    property :address
    property :dob
    property :image
    
    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VAILD_EMAIL_REGEX },
                      unique: true
    validates :phone, numericality: true, allow_blank: true, length: { maximum: 13 }
    validates :address, allow_blank: true, length: { maximum: 255 }
  end
end
