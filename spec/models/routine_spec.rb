require 'rails_helper'

RSpec.describe Routine, type: :model do
  let(:user) { create(:user) }
  context 'create可能' do
    it 'user_id,nameがある場合' do
      routine = create(:routine, user_id: user.id)
      expect(routine).to be_valid
    end
  end
  context 'create不可' do
    it 'user_idが無い場合' do
      example_routine = build(:routine)
      expect(example_routine).to_not be_valid
    end
    it 'nameが無い場合' do
      example_routine = build(:routine, user_id: user.id, name: nil)
      expect(example_routine).to_not be_valid
    end
  end
end
