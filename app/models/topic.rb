class Topic < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :facilitator_topics, dependent: :destroy
  has_many :facilitators, through: :facilitator_topics, source: :user

  validates :name, presence: true, length: {minimum: 3, maximum: 300}

  enum :category, {
    other: 0,
    work: 1,
    family: 2,
    wellness: 3,
    life: 4,
    health: 5,
    health_professional: 6
  }, default: :other
end
