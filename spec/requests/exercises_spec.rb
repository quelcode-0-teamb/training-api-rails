require 'rails_helper'

RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  before do
    @user_id = user.id
    @exercise_id = exercise.id
    @options = { 'HTTP_AUTHORIZATION': "Bearer #{user.token}" }
  end

  describe '/exercises POST' do
    subject { post '/exercises', headers: @options, params: @params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @params = {
        exercise_params: {
          "name": 'example_exercise',
          "category": 'バーベル'
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Exercise, :count).by(+1) }
    it { expect(res_body.length).to eq 6 }
  end

  describe '/exercises GET' do
    subject { get '/exercises', headers: @options }
    let(:res_body) do
      subject
      JSON.parse(response.bddy)
    end
    it { is_expected.to eq 200 }
  end

  describe '/exercises/exercise_id DELETE' do
    subject { delete "/exercises/#{@exercise_id}", headers: @options }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Exercise, :count).by(-1) }
  end

  describe '/exercises/exercise_id PUT' do
    subject { put "/exercises/#{@exercise_id}", headers: @options, params: @edit_params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @edit_params = {
        exercise_params: {
          "name": 'edit_exercise',
          "category": 'バーベル'
        }
      }
    end
    it { is_expected.to eq 200 }
  end
end
