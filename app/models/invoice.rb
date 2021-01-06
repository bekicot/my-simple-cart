class Invoice < ApplicationRecord

  belongs_to :user
  has_many :orders

  validates :user_id, presence: true
  
end
