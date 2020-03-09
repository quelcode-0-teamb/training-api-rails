require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  context 'create可能' do
    it 'follower,followedがある事、尚且つそれぞれ違うユーザーである場合' do
      example_relation = build(:relationship, follower: user, followed: user)
      expect(example_relation).to be_valid
    end
  end
  context 'create不可' do
    it 'followerがない場合' do
      example_relation = build(:relationship, follower: nil, followed: user)
      expect(example_relation).to_not be_valid
    end
    it 'followedがない場合' do
      example_relation = build(:relationship, follower: user, followed: nil)
      expect(example_relation).to_not be_valid
    end
    pending it 'follower,followedが同じユーザーである場合' do
      same_user = user
      example_relation = build(:relationship, follower: same_user, followed: same_user)
      expect(example_relation).to_not be_valid
    end
  end
end
