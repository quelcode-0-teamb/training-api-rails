require 'rails_helper'
require 'pry'
# インスタンス変数じゃないとうまくいかなかった。。
RSpec.describe 'RoutineExercises', type: :request do
  before do
    @user = create(:user)
    @exercise = create(:exercise, user: @user)
    @routine = create(:routine, user: @user)
    @params = {
      "routine_exercise_params": [
        { "exercise_id": @exercise.id },
        { "exercise_id": @exercise.id },
        { "exercise_id": @exercise.id }
      ]
    }
  end
  describe 'create' do
    subject(:routine_exercise_score) do
      options ||= {}
      options['HTTP_AUTHORIZATION'] = "Bearer #{@user.token}"
      post "/routines/#{@routine.id}/routine_exercises", headers: options, params: @params
    end
    it { is_expected.to eq 200 }
  end
  describe 'destroy' do
    let!(:routine_exercises) { create(:routine_exercise, exercise: @exercise, routine: @routine) }
    subject(:delete_exercise_score) do
      options ||= {}
      options['HTTP_AUTHORIZATION'] = "Bearer #{@user.token}"
      delete "/routines/#{@routine.id}/routine_exercises/#{routine_exercises.id}", headers: options
    end
    it { is_expected.to eq 200 }
    it { expect { delete_exercise_score }.to change(RoutineExercise, :count).by(-1) }
  end
end
