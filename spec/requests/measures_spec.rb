require 'rails_helper'
require 'pry'

RSpec.describe 'measures', type: :request do
  let(:user) { create(:user) }
  let(:measure) { create(:measure, user_id: user.id) }
  before do
    @user_id = user.id
    @measure_id = measure.id
    @options = { 'HTTP_AUTHORIZATION': "Bearer #{user.token}" }
  end

  describe '/measures' do
    describe 'POST' do
      subject { post '/measures', headers: @options, params: @params }
      let(:res_body) do
        subject
        JSON.parse(response.body)
      end
      before do
        @params = {
          "measure_params": {
            "body_weight": 1,
            "body_fat": 1,
            "calorie": 1,
            "neck": 1,
            "shoulder": 1,
            "chest": 1,
            "left_biceps": 1,
            "right_biceps": 1,
            "left_forearm": 1,
            "right_forearm": 1,
            "upper_abdomen": 1,
            "lower_abdomen": 1,
            "waist": 1,
            "hips": 1,
            "left_thigh": 1,
            "right_thigh": 1,
            "left_calf": 1,
            "right_calf": 1,
            "date": '2012/2/2'
          }
        }
      end
      it { is_expected.to eq 200 }
      it { expect { subject }.to change(Measure, :count).by(+1) }
      it { expect(res_body.length).to eq 23 }
    end
  end

  describe '/measure/:measure_id' do
    describe 'DELETE' do
      subject { delete "/measures/#{@measure_id}", headers: @options }
      it { is_expected.to eq 200 }
      it { expect { subject }.to change(Measure, :count).by(-1) }
    end

    describe 'PUT' do
      subject { put "/measures/#{@measure_id}", headers: @options, params: @edit_params }
      let(:res_keys) { %w[body_weight body_fat body_fat] }
      let(:res_body) do
        subject
        JSON.parse(response.body)
      end
      before do
        @edit_params = {
          "measure_params": {
            "body_weight": 10,
            "body_fat": 10,
            "date": '2015/2/2'
          }
        }
      end
      it { is_expected.to eq 200 }
      it { expect(res_body.length).to eq 23 }
      it 'リクエストデータとレスポンスデータが一致' do
        res_keys.each do |key|
          expect(res_body[key]).to eq @edit_params[:measure_params][key.intern]
        end
      end
    end
  end

  describe '/users/:user_id/measures GET' do # ユーザのmeasuresの取得
    subject { get "/users/#{@user_id}/measures", headers: @options }
    it { is_expected.to eq 200 }
  end
end
