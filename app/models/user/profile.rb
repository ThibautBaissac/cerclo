class User::Profile < ApplicationRecord
  belongs_to :user

  normalizes :firstname, with: ->(firstname) { firstname.strip }
  normalizes :lastname, with: ->(lastname) { lastname.strip }

  validates :firstname, :lastname, presence: true
  validates :bio, length: {maximum: 500}, allow_blank: true

  def fullname
    [ firstname, lastname ].compact.join(" ").presence
  end
end
