class Group::Member < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum :status, {
    confirmed: 0,
    present: 1,
    rejected: 2,
    waitlisted: 3,
    invited: 4
  }, default: :confirmed

  validates :user_id, uniqueness: {scope: :group_id, message: "est déjà membre de ce groupe"}
  validate :validate_group_capacity, on: :create, if: -> { confirmed? }

  scope :confirmed, -> { where(status: :confirmed) }
  scope :present, -> { where(status: :present) }
  scope :rejected, -> { where(status: :rejected) }
  scope :waitlisted, -> { where(status: :waitlisted) }
  scope :invited, -> { where(status: :invited) }

  private

  def validate_group_capacity
    return unless group.present?
    return unless group.full?

    self.status = :waitlisted
  end
end
