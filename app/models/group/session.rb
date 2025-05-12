class Group::Session < ApplicationRecord
  belongs_to :group
  has_many :group_session_participants, class_name: "Group::Session::Participant", foreign_key: :group_session_id, dependent: :destroy
  has_many :participants, through: :group_session_participants, source: :user, class_name: "::User"

  validates :starts_at, presence: true
  validate :starts_at_in_future

  scope :upcoming, -> { where("starts_at > ?", Time.current).order(:starts_at) }
  scope :past,     -> { where("starts_at < ?", Time.current).order(starts_at: :desc) }

  def ends_at
    starts_at + group.duration.minutes
  end

  def confirmed_participants
    users.joins(:group_session_participants).where(group_session_participants: {status: :confirmed})
  end

  def invited_participants
    users.joins(:group_session_participants).where(group_session_participants: {status: :invited})
  end

  def present_participants
    users.joins(:group_session_participants).where(group_session_participants: {status: :present})
  end

  def participant_count
    group_session_participants.where(status: [ :confirmed, :present ]).count
  end

  def spots_available
    group.max_participants - participant_count
  end

  def full?
    spots_available <= 0
  end

  private

  def starts_at_in_future
    return unless starts_at.present? && starts_at <= Time.current

    errors.add(:starts_at, "doit être dans le futur")
  end
end
