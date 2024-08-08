class UsersController < ApplicationController
  before_action :admin?, only: [:index, :show, :destroy]
  before_action :member?, only: [:new, :create]
  skip_before_action :authorized?, only: [:new, :create]
  def index
    run User::Operation::Index do |result|
      @users = result[:users]
    end
  end

  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create do |result|
      return redirect_to users_path, notice: 'User created successfully'
    end
    flash[:alert] = 'Failed to create user'
    render :new, status: :unprocessable_entity
  end

  def show
    run User::Operation::Show
    return result[:model]
  end

  def edit
    run User::Operation::Update::Present
    return result[:model]
  end

  def update
    run User::Operation::Update do |result|
      return redirect_to user_path(result[:model]), notice: 'User updated successfully'
    end
    flash[:alert] = 'Failed to update user'
    render :edit, status: :unprocessable_entity
  end

  def destroy
    run User::Operation::Destroy do |result|
      return redirect_to users_path, notice: 'User deleted successfully'
    end
  end

  def edit_profile
    run User::Operation::UpdateProfile::Present, user_id: current_user.id
  end

  def update_profile
    run User::Operation::UpdateProfile, user_id: current_user.id do |result|
      return redirect_to profile_users_path, notice: 'Profile updated successfully'
    end
    render :edit_profile
  end

  def edit_password
    run User::Operation::UpdatePassword::Present, user_id: current_user.id
  end

  def update_password
    run User::Operation::UpdatePassword, user_id: current_user.id do |result|
      return redirect_to profile_users_path, notice: 'Change Password successfully'
    end
    render :edit_password
  end
end
