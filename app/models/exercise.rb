class Exercise < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :category, presence: true
  belongs_to :user
  has_many :routine_esercises, dependent: :destroy
  has_many :routines,  through: :routine_exercise
  # デフォルトの種目を探す
  scope :default, -> { where(user_id: nil) }
  has_many :scores, dependent: :destroy
  enum category: { "バーベル": 0, "自重": 1, "ウェイトリフティング": 2, "ダンベル": 3, "マシン": 4 }
end
