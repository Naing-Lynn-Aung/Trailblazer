module Post::Operation
  class Search < Trailblazer::Operation
    step :search_posts!

    def search_posts!(options, params:, **)
      options[:model] = Post.where("title LIKE :search or description LIKE :search", search: "%#{params[:search_keyword]}%")
      options[:last_search_keyword] = params[:search_keyword]
    end
  end
end
