require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:user) { create(:user) }
  context 'create可能' do
    it 'user_id,name,categoryがある場合' do
      example_exercise = build(:exercise, user_id: user.id)
      expect(example_exercise).to be_valid
    end
  end
  context 'create不可' do
    it 'user_idが無い場合' do
      example_exercise = build(:exercise, user_id: nil)
      expect(example_exercise).to_not be_valid
    end
    it 'categoryが無い場合' do
      example_exercise = build(:exercise, user_id: user.id, category: nil)
      expect(example_exercise).to_not be_valid
    end
    it 'nameが無い場合' do
      example_exercise = build(:exercise, user_id: user.id, name: nil)
      expect(example_exercise).to_not be_valid
    end
  end
end
