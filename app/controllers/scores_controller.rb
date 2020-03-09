class ScoresController < ApplicationController
  before_action :authorize!
  before_action :set_score, only: %i[destroy update]
  before_action :check_auth_user, only: %i[destroy update]
  def create
    set_num = params[:sets].to_i
    score = Score.add_exercise_to_scores(score_params, set_num, params[:id], current_user)
    render json: score.as_json
  end

  def update
    check_params_present(score_params)
    @score.update!(@params_array)
    render json: @score.as_json
  end

  def destroy
    @score.destroy!
    render json: { "message": '削除しました' }
  end

  def routine_score
    Score.add_routine_scores(params[:routine_score_params], current_user)
    render json: { "message": '記録しました' }
  end

  private

  def routine_score_params
    params.require(:routine_score_params).permit(
      score_params:
       %i[
         weight
         repetitions
         interval_time
         rpe
         date
       ]
    )
  end

  def score_params
    params.require(:score_params).permit(
      :weight,
      :repetitions,
      :interval_time,
      :rpe,
      :date
    )
  end

  def set_score
    @score = Score.find(params[:id])
  end

  def check_auth_user
    return if current_user.id == @score.user_id

    raise ActionController::BadRequest, 'この項目は変更、削除できません！'
  end
end
