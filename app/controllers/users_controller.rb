class UsersController < ApplicationController
  before_action :authorize!, only: %i[update destroy show measures followings followers scores routines]
  before_action :set_user, only: %i[update destroy show measures followings followers scores routines]
  before_action :check_auth_user, only: %i[update destroy]
  before_action :check_user_private, only: %i[measures followings followers scores routines]

  def top
    readme_url = 'https://mukimukiroku.herokuapp.com/'
    render json: { 'welcome!': 'APIサーバーだよ', 'how_to_use': readme_url }
  end

  # ユーザー登録
  def sign_up
    user = User.create!(sign_up_params)
    render json: user.as_json, status: :created
  end

  # ログイン
  def sign_in
    sign_in_check(params[:sign_in_params][:sign_in_text])
    if @data.blank?
      raise(ActiveRecord::RecordNotFound, 'ユーザー名、emailが見つかりません') and return
    end
    if @data.authenticate(params[:sign_in_params][:password])
      render json: @data.as_json
    else
      raise(ActionController::BadRequest, 'パスワードが間違っています') and return
    end
  end

  # ユーザー情報変更
  def update
    check_params_present(user_update_params)
    @user.update!(@params_array)
    render json: @user
  end

  # ユーザー消去
  def destroy
    @user.destroy!
    render status: :no_content
  end

  def show
    response = if @current_user == @user
                 UserSerializer.new(@current_user)
               else
                 {
                   "user": OtherUserSerializer.new(@user),
                   "follow_status": @current_user.follow_status(@user)
                 }
               end
    render json: response.as_json
  end

  def measures
    render json: @user.measures.date_desc
  end

  def followings
    render json: @user.followings
  end

  def followers
    render json: @user.followers
  end

  def scores
    render json: @user.scores
  end

  def routines
    render json: @user.routines
  end

  private

  # ユーザーの公開確認
  def check_user_private
    return if @current_user == @user

    return unless @user.user_private

    return if current_user.following?(@user)

    raise(ActionController::BadRequest, '非公開ユーザーです')
  end

  def check_auth_user
    return if @current_user == @user

    raise ActionController::BadRequest, 'ユーザーが違います！'
  end

  # ユーザー名とemailを判別
  def sign_in_check(data)
    @data = if data.include?('@')
              User.find_by(email: params[:sign_in_params][:sign_in_text])
            else
              User.find_by(name: params[:sign_in_params][:sign_in_text])
            end
  end

  def sign_up_params
    params.require(:sign_up_params).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :user_private
    )
  end

  def sign_in_params
    params.require(:sign_in_params).permit(
      :sign_in_text,
      :password,
      :password_confirmation
    )
  end

  def user_update_params
    params.require(:user_update_params).permit(
      :name,
      :email,
      :user_private
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
