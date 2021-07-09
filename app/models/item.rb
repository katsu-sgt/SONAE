class Item < ApplicationRecord
  validates :user_id, presence: true
  validates :item_name, presence: true
  validates :number, presence: true
  
  belongs_to :user
end
