require 'rails_helper'

RSpec.describe ScoresController, type: :controller do
  let!(:user1) { create(:user1) }
  let!(:user2) { create(:user2) }
  it 'delete the user1' do
    expect do
      delete :destroy, params: { id: user1.id }
    end.to_not change(User, :count)
  end

  it 'saves the new user2 in the database' do
    expect do
      post :create, params: { id: user2.id }
    end.to_not change(User, :count)
  end
end
