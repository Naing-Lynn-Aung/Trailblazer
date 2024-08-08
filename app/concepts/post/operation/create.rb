module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end
    step Nested(Present)
    step :current_user!
    step Contract::Validate(key: :post)
    step Contract::Persist()

    def current_user!(options, **)
      options[:params][:post][:user_id] = options['current_user'][:id]
    end
  end
end
