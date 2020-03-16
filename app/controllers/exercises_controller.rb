class ExercisesController < ApplicationController
  before_action :authorize!
  before_action :set_exercise, only: %i[destroy update]
  before_action :check_auth_user, only: %i[destroy update]

  def create
    exercise = current_user.exercises.create(exercise_params)
    render json: exercise, status: :created
  end

  def destroy
    @exercise.destroy!
    render status: :no_content
  end

  def update
    @exercise.update!(exercise_params)
    render json: @exercise
  end

  def index
    if params[:category].blank?
      default_exercise = Exercise.default
      user_exercise = @current_user.exercises
      exercises = default_exercise + user_exercise
    else
      exercises = Exercise.where(category: params[:category])
    end
    render json: exercises
  end

  private

  def exercise_params
    params.require(:exercise_params).permit(
      :name,
      :category
    )
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def check_auth_user
    return if @current_user.id == @exercise.user_id

    raise ActionController::BadRequest, 'この種目は変更、削除できません！'
  end
end
