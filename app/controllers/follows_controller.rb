class FollowsController < ApplicationController
  before_action :authorize!
  # before_action :set_user
  before_action :check_is_already_follow, only: [:create]
  # before_action :check_is_not_follow_yet, only: [:destroy]

  def create
    user = User.find(params[:id])
    if user.user_private
      current_user.follow_request(user)
    else
      current_user.follow(user)
    end
      render status: :created
  end

  def destroy
    @current_user.unfollow(@user)
    render status: :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_is_already_follow
    user = User.find(params[:id])
    if current_user.followings.find_by(id: user.id).present?
      raise(ActionController::BadRequest, 'すでにフォローしています') and return
    elsif current_user.requests.find_by(id: user.id).present?
      raise(ActionController::BadRequest, 'すでにフォローリクエストしています') and return
    end
  end

  def check_is_not_follow_yet
    if @current_user.followings.find_by(id: @user.id).blank?
      raise(ActionController::BadRequest, 'まだフォローしてないからフォロー解除できません') and return
    end
  end
end
