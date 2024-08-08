module Post::Operation
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :find_by)
      step Contract::Build(constant: Post::Contract::Update)
    end
    step Nested(Present)
    step Contract::Validate(key: :post)
    step Contract::Persist()
  end
end
