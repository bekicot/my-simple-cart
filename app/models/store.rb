class Store < ApplicationRecord

  has_many :products

  validates :name, :description, :address, presence: :true

end
