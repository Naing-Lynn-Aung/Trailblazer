class PostsController < ApplicationController
  before_action :authorized?
  def index
    run Post::Operation::Index
  end

  def new
    run Post::Operation::Create::Present
  end

  def create
    run Post::Operation::Create, current_user: current_user do |result|
      return redirect_to posts_path, notice: 'Post created successfully'
    end
    flash[:alert] = 'Failed to create post'
    render :new, status: :unprocessable_entity
  end

  def show
    run Post::Operation::Show
    return result[:model]
  end

  def edit
    run Post::Operation::Update::Present
  end

  def update
    run Post::Operation::Update, current_user: current_user do |result|
      return redirect_to post_path, notice: 'Post updated successfully'
    end
    flash[:alert] = 'Failed to update post'
    render :edit, status: :unprocessable_entity
  end

  def destroy
    run Post::Operation::Destroy do |result|
      redirect_to posts_path, notice: 'Post deleted successfully'
    end
  end

  def search
    run Post::Operation::Search do |result|
      @last_search_keyword = result[:last_search_keyword]
      render :index
      return
    end
  end

  def filter
    run Post::Operation::Filter, current_user_id: current_user.id do |result|
      @last_filter = result[:last_filter]
      render :index
      return
    end
  end

  def export
    run Post::Operation::Export::CsvData, current_user: current_user do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_text], filename: "#{Time.new.strftime("%Y/%m/%d-%I:%M:%S")}.csv" }
      end
    end
  end

  def csv_format
    run Post::Operation::Export::Format do |result|
      respond_to do |format|
        format.html
        format.csv { send_data result[:csv_format], filename: 'format.csv' }
      end
    end
  end
  def import
    
  end

  def importCsv
    run Post::Operation::Import, current_user_id: current_user.id do |result|
      return redirect_to posts_path, notice: 'Import CSV successfully'
    end
    flash[:alert] = 'Something is wrong. Please check your csv format'
    render :import, status: :unprocessable_entity
    return
  end
end
