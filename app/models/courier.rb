class Courier < ApplicationRecord

  validates :name, :price, presence: true
end
