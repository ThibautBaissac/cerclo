class Group < ApplicationRecord
  MIN_PARTICIPANTS_COUNT = 2

  belongs_to :topic
  has_many :members, dependent: :destroy, class_name: "Group::Member"
  has_many :users, through: :members
  has_many :participants, -> { where(users: {role: :member}) }, through: :members, source: :user
  has_many :facilitators, -> { where(users: {role: :facilitator}) }, through: :members, source: :user
  has_many :group_sessions, dependent: :destroy, class_name: "Group::Session"

  normalizes :title, with: ->(title) { title.strip }
  normalizes :sub_title, with: ->(subtitle) { subtitle&.strip }

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: {minimum: 10, maximum: 100}
  validates :sub_title, length: {maximum: 200}, allow_blank: true
  validates :description, presence: true, length: {minimum: 100, maximum: 5000}
  validates :min_participants, numericality: {only_integer: true, greater_than_or_equal_to: MIN_PARTICIPANTS_COUNT}
  validates :max_participants, numericality: {only_integer: true, greater_than_or_equal_to: :min_participants}

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

  def has_facilitator?
    facilitators.exists?
  end

  def is_facilitator?(user)
    facilitators.exists?(id: user.id)
  end

  def next_sessions
    group_sessions.where("starts_at > ?", Time.current).order(:starts_at)
  end

  def next_session
    next_sessions.first
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
end
