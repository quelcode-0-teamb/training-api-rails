class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def date_presence_check
    lowest = Date.parse('2000/1/1')
    errors.add(:date, '日付が間違っています') if date.nil? || date < lowest || date > Time.zone.today
  end
end
