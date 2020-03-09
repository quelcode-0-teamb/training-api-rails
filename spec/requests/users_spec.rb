require 'rails_helper'
require 'pry'

RSpec.describe 'Users', type: :request do
  context '非ログイン時' do
    describe '/ GET' do
      subject { get '/' }
      it { is_expected.to eq 200 }
    end
  end

  describe '/sign_up POST' do
    let(:params) { attributes_for(:user) }
    subject(:sign_up) { post '/sign_up', params: { "sign_up_params": params } }
    let(:res_keys) { %w[name email] }
    let(:res_body) do
      sign_up
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
    it { expect { sign_up }.to change(User, :count).by(+1) }
    it { expect(res_body.length).to eq 8 }
    it 'usersに追加されたデータと送ったデータが一致' do
      db_added_user = User.find(res_body['id'])
      res_keys.each { |key| expect(db_added_user[key]).to eq params[key.intern] }
    end
    it 'レスポンスデータが期待どおり' do
      res_keys.each { |key| expect(res_body[key]).to eq params[key.intern] }
      expect(res_body['token'].length).to eq 24
    end
    it 'usersに追加されたトークンとレスポンスのトークンが一致' do
      db_added_user = User.find(res_body['id'])
      expect(res_body['token']).to eq db_added_user.token
    end
  end

  describe '/login POST' do
    let(:sign_up_params) { attributes_for(:user) }
    subject(:login) { post '/sign_in', params: @params }
    let(:res_keys) { %w[id name token email] }
    let(:res_body) do
      login
      JSON.parse(response.body)
    end
    before do
      @user = User.create(sign_up_params)
      @params = {
        "sign_in_params": {
          "sign_in_text": sign_up_params[:email],
          "password": sign_up_params[:password]
        }
      }
    end
    it { is_expected.to eq 200 }
    it { expect(res_body.length).to eq 8 }
    it 'usersに追加されたデータとレスポンスデータが一致' do
      res_keys.each { |key| expect(res_body[key]).to eq @user[key] }
    end
    context 'paramsが異なる時' do
      it 'wrong email bad response' do
        @params[:sign_in_params][:sign_in_text] = 'wrong@example.com'
        expect(login).to eq 404
      end
      it 'wrong password bad response' do
        @params[:sign_in_params][:password] = 'wrongpasrsword'
        expect(login).to eq 400
      end
    end
  end

  context 'ログイン時' do
    describe 'users' do
      let(:user) { create(:user) }
      before do
        @user_id = user.id
        @options ||= {}
        @options['HTTP_AUTHORIZATION'] = "Bearer #{user.token}"
      end
      describe '/users/:id' do
        describe 'show' do
          subject(:show_user) do
            get "/users/#{@user_id}", headers: @options
          end
          let(:res_body) do
            show_user
            JSON.parse(response.body)
          end
          it { is_expected.to eq 200 }
        end
        describe 'update' do
          subject(:update_user) do
            put "/users/#{@user_id}", headers: @options, params: @params
          end
          let(:res_body) do
            update_user
            JSON.parse(response.body)
          end
          before do
            @params = {
              "user_update_params": {
                "name": 'updateName',
                "email": 'update@gmail.com',
                "user_private": 'true'
              }
            }
          end
          it { is_expected.to eq 200 }
        end
        describe 'delete' do
          subject(:delete_user) do
            delete "/users/#{@user_id}", headers: @options
          end
          it { is_expected.to eq 200 }
          it { expect { subject }.to change(User, :count).by(-1) }
        end
      end
    end
  end
end
