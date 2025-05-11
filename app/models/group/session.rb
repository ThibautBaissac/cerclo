class Group::Session < ApplicationRecord
  MIN_DURATION = 10
  MAX_DURATION = 120

  belongs_to :group

  validates :starts_at, presence: true
  validates :duration, presence: true
  validates :duration, numericality: {only_integer: true, greater_than_or_equal_to: MIN_DURATION}
  validates :duration, numericality: {less_than_or_equal_to: MAX_DURATION}
  validates :starts_at, comparison: {greater_than: Time.current, message: "doit être dans le futur"}

  def ends_at
    starts_at + duration.minutes
  end

  def duration_in_hours
    duration / 60
  end
end
