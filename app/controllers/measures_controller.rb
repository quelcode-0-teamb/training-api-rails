class MeasuresController < ApplicationController
  before_action :authorize!
  before_action :set_measure, only: %i[destroy update]
  before_action :check_auth_user, only: %i[destroy update]

  # 計測記録の作成
  def create
    measure = Measure.new(measure_params)
    measure.user = @current_user
    measure.save!
    render status: :created
  end

  # 記録の消去
  def destroy
    @measure.destroy!
    render status: :no_content
  end

  # 計測記録の作成
  def update
    check_params_present(measure_params)
    @measure.update!(@params_array)
    render json: @measure
  end

  private

  def set_measure
    @measure = Measure.find(params[:id])
  end

  def check_auth_user
    return if @current_user.id == @measure.user_id

    raise ActionController::BadRequest, 'この記録はnameが違うので変更、削除できません！'
  end

  def measure_params
    params.require(:measure_params).permit(
      :body_weight,
      :body_fat,
      :calorie,
      :neck,
      :shoulder,
      :chest,
      :left_biceps,
      :right_biceps,
      :left_forearm,
      :right_forearm,
      :upper_abdomen,
      :lower_abdomen,
      :waist,
      :hips,
      :left_thigh,
      :right_thigh,
      :left_calf,
      :right_calf,
      :date
    )
  end
end
