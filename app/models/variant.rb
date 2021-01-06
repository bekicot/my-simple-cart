class Variant < ApplicationRecord

  has_many :variant_options

  validates :name, presence: true
end
