module Post::Contract
  class Update < Reform::Form
    property :title
    property :description
    property :privacy
    property :user_id

    validates :title, presence: true
    validates :description, presence: true
    validates :privacy, presence: true
  end
end
