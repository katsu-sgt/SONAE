class Shelter < ApplicationRecord
  validates :user_id, presence: true
  validates :shelter_name, presence: true
  validates :address, presence: true

  belongs_to :user
end
