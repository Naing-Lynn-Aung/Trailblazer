module Post::Operation
  class Filter < Trailblazer::Operation
    step :filter_posts!

    def filter_posts!(options, params:, **)
      case params[:filter]
      when 'All'
        options[:model] = Post.all.order('id DESC')
      when 'Other Posts'
        options[:model] = Post.where.not(user_id: options[:current_user_id]).order('id DESC')
      when 'My Posts'
        options[:model] = Post.where(user_id: options[:current_user_id]).order('id DESC')
      end
      options[:last_filter] = params[:filter]
    end
  end
end
