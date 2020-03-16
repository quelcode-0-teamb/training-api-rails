class FollowRequestsController < ApplicationController
  before_action :authorize!
  before_action :set_request_user, only: %i[update destroy my_request_cancel]
  before_action :check_follow_request_recipients, only: %i[update destroy]
  before_action :check_follow_request, only: [:my_request_cancel]

  # 受け取ったフォローリクエストのユーザー一覧
  def index
    render json: @current_user.recipients
  end

  # フォローリクエスト承認
  def update
    ActiveRecord::Base.transaction do
      @request_user.follow(@current_user)
      @request_user.request_cancel(@current_user)
      render stasus: :created
    end
  end

  # フォローリクエスト拒否
  def destroy
    @request_user.request_cancel(@current_user)
    render status: :no_content
  end

  # 送ったフォローリクエスト一覧
  def my_requests
    render json: @current_user.requests
  end

  # フォローリクエスト取り消し
  def my_request_cancel
    @current_user.request_cancel(@request_user)
    render status: :no_content
  end

  private

  def set_request_user
    @request_user = User.find(params[:id])
  end

  def check_follow_request_recipients
    return if @current_user.recipients.find_by(id: @request_user).present?

    raise(ActionController::BadRequest, 'そのユーザーからフォローリクエストを受けていません')
  end

  def check_follow_request
    return if @current_user.requests.find_by(id: @request_user).present?

    raise(ActionController::BadRequest, 'そのフォローリクエストは存在しません')
  end
end
