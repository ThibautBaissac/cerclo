class Group::Member < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: {scope: :group_id, message: "est déjà membre de ce groupe"}
  validate :validate_group_capacity, on: :create, if: -> { confirmed? }

  enum :status, {
    confirmed: 0,
    rejected: 1,
    waitlisted: 2
  }, default: :confirmed

  scope :confirmed, -> { where(status: :confirmed) }
  scope :rejected, -> { where(status: :rejected) }
  scope :waitlisted, -> { where(status: :waitlisted) }

  delegate :username, to: :user, allow_nil: true

  private

  def validate_group_capacity
    return unless group.present?
    return unless group.full?

    self.status = :waitlisted
  end
end
