require 'rails_helper'

RSpec.describe Measure, type: :model do
  let(:user) { create(:user) }
  context 'create可能' do
    it 'user_id,dateがある場合' do
      example_measure = build(:measure, user_id: user.id)
      expect(example_measure).to be_valid
    end
  end
  context 'create不可能' do
    it 'user_idが無い場合' do
      example_score = build(:measure, user_id: nil)
      expect(example_score).to_not be_valid
    end
    describe 'date' do
      it '無い場合' do
        example_score = build(:measure, user_id: user.id, date: nil)
        expect(example_score).to_not be_valid
      end
      it '未来の場合' do
        future = Time.zone.today + 1
        example_score = build(:measure, user_id: user.id, date: future)
        expect(example_score).to_not be_valid
      end
      it '西暦が2000年、以下の場合' do
        example_score = build(:measure, user_id: user.id, date: '1999/12/31')
        expect(example_score).to_not be_valid
      end
    end
  end
end
