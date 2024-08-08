module Post::Contract
  class Import < Reform::Form
    property :file, virtual: true

    validates :file, presence: true
  end
end
