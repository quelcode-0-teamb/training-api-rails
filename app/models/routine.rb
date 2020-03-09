class Routine < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  belongs_to :user
  has_many :routine_exercises, dependent: :destroy
  has_many :exercises, through: :routine_exercises
end
