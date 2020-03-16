class Measure < ApplicationRecord
  validate :date_presence_check # 記録日の論理チェック ApplicationRecordに定義
  belongs_to :user
  scope :date_desc, -> { order(date: :desc) }
end
