class Group < ApplicationRecord
  MIN_DURATION = 10
  MAX_DURATION = 120
  MIN_PARTICIPANTS_COUNT = 2
  MAX_PARTICIPANTS_COUNT = 10

  belongs_to :topic
  belongs_to :facilitator, class_name: "User"
  has_many :members, dependent: :destroy, class_name: "Group::Member"
  has_many :participants, -> { where(users: {role: :member}) }, through: :members, source: :user
  has_many :group_sessions, dependent: :destroy, class_name: "Group::Session"

  normalizes :title, with: ->(title) { title.strip }
  normalizes :sub_title, with: ->(subtitle) { subtitle&.strip }

  enum :frequency, {daily: 0, biweekly: 1, weekly: 2}, default: :weekly

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: {minimum: 10, maximum: 100}
  validates :sub_title, length: {maximum: 200}, allow_blank: true
  validates :description, presence: true, length: {minimum: 100, maximum: 5000}
  validates :min_participants, numericality: {only_integer: true, greater_than_or_equal_to: MIN_PARTICIPANTS_COUNT}
  validates :max_participants, numericality: {less_than_or_equal_to: MAX_PARTICIPANTS_COUNT}
  validates :duration, presence: true
  validates :duration, numericality: {only_integer: true, greater_than_or_equal_to: MIN_DURATION}
  validates :duration, numericality: {less_than_or_equal_to: MAX_DURATION}
  validates :frequency, presence: true
  validate :participants_range

  before_validation :generate_uuid, on: :create

  def spots_available?
    confirmed_members.count < max_participants
  end

  def spots_available_count
    max_participants - confirmed_members.count
  end

  def confirmed_members
    members.confirmed
  end

  def present_members
    members.present
  end

  def full?
    confirmed_members.count >= max_participants
  end

  def is_member?(user)
    members.exists?(user_id: user.id)
  end

  def is_facilitator?(user)
    facilitator_id == user.id
  end

  def next_session
    group_sessions.upcoming.first
  end

  def ended_sessions
    group_sessions.where("starts_at < ?", Time.current).order(starts_at: :desc)
  end

  def to_param
    uuid
  end

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def participants_range
    return if max_participants >= min_participants

    errors.add(:max_participants, "must be ≥ min participants")
  end
end
