class RoutinesController < ApplicationController
  before_action :authorize!
  before_action :set_routine, only: %i[destroy update show]
  before_action :check_auth_user, only: %i[destroy update show]

  def create
    routine = Routine.new(routine_params)
    routine.user = @current_user
    routine.save!
    render status: :created
  end

  def destroy
    @routine.destroy
    render status: :no_content
  end

  def update
    @routine.update!(routine_params)
    render json: @routine
  end

  def show
    routine_exercise = @routine.routine_exercises.order(created_at: :asc).includes(:exercise)
    render json: routine_exercise, each_serializer: RoutineExercisesSerializer
  end

  private

  def routine_params
    params.require(:routine_params).permit(
      :name
    )
  end

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def check_auth_user
    return if @current_user.id == @routine.user_id

    raise ActionController::BadRequest, 'ユーザーが違います！'
  end
end
