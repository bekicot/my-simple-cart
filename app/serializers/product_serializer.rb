class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  belongs_to :store
  has_many :product_variants

end
