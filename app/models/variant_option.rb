class VariantOption < ApplicationRecord

  belongs_to :variant

  validates :name, presence: :true
end
