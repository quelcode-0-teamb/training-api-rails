require 'rails_helper'
require 'pry'

RSpec.describe 'routine', type: :request do
  let(:user) { create(:user) }
  let(:routine) { create(:routine, user_id: user.id) }
  before do
    @user_id = user.id
    @routine_id = routine.id
    @options = { 'HTTP_AUTHORIZATION': "Bearer #{user.token}" }
  end

  describe '/routines POST' do
    subject { post '/routines', headers: @options, params: @params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @params = {
        "routine_params": {
          "name": 'example'
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Routine, :count).by(+1) }
    it { expect(res_body.length).to eq 5 }
  end

  describe '/routines/:routines_id DELETE' do
    subject { delete "/routines/#{@routine_id}", headers: @options }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
    it { expect { subject }.to change(Routine, :count).by(-1) }
  end

  describe '/routines/:routines_id PUT' do
    subject { put "/routines/#{@routine_id}", headers: @options, params: @edit_routine_params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    before do
      @edit_routine_params = {
        "routine_params": {
          "name": 'edit_example'
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect(res_body.length).to eq 5 }
  end
  describe '/users/:id/routines GET' do
    subject { get "/users/#{@user_id}/routines", headers: @options }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
  end

  describe '/routines/:routine_id GET' do
    subject { get "/routines/#{@routine_id}", headers: @options }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
  end
end
