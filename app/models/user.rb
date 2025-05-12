class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_one :profile, dependent: :destroy
  has_many :facilitator_topics, dependent: :destroy
  has_many :topics, through: :facilitator_topics
  has_many :groups, foreign_key: "facilitator_id", dependent: :restrict_with_error

  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :username, with: ->(username) { username.strip.downcase }

  enum :role, {member: 0, facilitator: 1, admin: 2, super_admin: 3}, default: :member

  before_validation :generate_uuid, on: :create

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :uuid, presence: true, uniqueness: true
  validates :username, presence: true,
            format: {with: /\A[a-zA-Z0-9_.-]+\z/, message: "peut contenir uniquement des lettres, chiffres, tirets et underscores"},
            length: {minimum: 3, maximum: 30}

  delegate :fullname, :job, :short_bio, :bio, to: :profile, allow_nil: true

  def admin_or_super_admin?
    admin? || super_admin?
  end

  def to_param
    uuid
  end

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
