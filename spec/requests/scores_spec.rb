require 'rails_helper'
RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:score) { create(:score, user_id: user.id, exercise_id: exercise.id) }
  before do
    @user_id = user.id
    @exercise_id = exercise.id
    @score_id = score.id
    @options = { 'HTTP_AUTHORIZATION': "Bearer #{user.token}" }
  end
  describe '/exercises/:exercise_id/score POST' do
    subject { post "/exercises/#{@exercise_id}/score", headers: @options, params: @params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @params = {
        "sets": 3,
        "score_params": {
          "weight": 10,
          "repetitions": 3,
          "interval_time": 30,
          "rpe": 60,
          "date": '2020/1/10'
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Score, :count).by(+@params[:sets]) }
    it { expect(res_body.length).to eq @params[:sets] }
  end

  describe '/scores/:score_id DELETE' do
    subject { delete "/scores/#{@score_id}", headers: @options }
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Score, :count).by(-1) }
  end

  describe '/scores/:score_id PUT' do
    subject { put "/scores/#{@score_id}", headers: @options, params: @edit_params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @edit_params = {
        "score_params": {
          "weight": 100,
          "repetitions": 5,
          "interval_time": 50,
          "rpe": 120,
          "date": '2020/2/10'
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect(res_body.length).to eq 10 }
  end

  describe '/users/:user_id/scores GET' do
    subject { get "/users/#{@user_id}/scores", headers: @options }
    it { is_expected.to eq 200 }
  end
end
