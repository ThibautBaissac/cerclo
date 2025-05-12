class Group::Session::Participant < ApplicationRecord
  belongs_to :group_session, class_name: "Group::Session"
  belongs_to :user, class_name: "::User", foreign_key: :user_id

  validates :user_id, uniqueness: {scope: :group_session_id, message: "est déjà membre de cette session"}

  enum :status, {
    confirmed: 0,
    present: 1,
    rejected: 2,
    waitlisted: 3,
    invited: 4
  }, default: :confirmed
end
