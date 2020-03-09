require 'rails_helper'

RSpec.describe 'Follows', type: :request do
  describe 'relation' do
    let!(:me) { create(:user) }
    let!(:other_user) { create(:user) }
    describe 'create' do
      subject(:relation_create) do
        options ||= {}
        options['HTTP_AUTHORIZATION'] = "Bearer #{me.token}"
        post "/users/#{other_user.id}/follow", headers: options
      end
      it { is_expected.to eq 200 }
    end
    describe 'destroy' do
      let!(:relation) { create(:relationship, follower: me, followed: other_user) }
      subject(:delete_relation) do
        options ||= {}
        options['HTTP_AUTHORIZATION'] = "Bearer #{relation.follower.token}"
        delete "/users/#{relation.followed.id}/follow", headers: options
      end
      it { is_expected.to eq 200 }
      it { expect { delete_relation }.to change(Relationship, :count).by(-1) }
    end
  end
end
