class CartSerializer < ActiveModel::Serializer
  attributes :id
  
  belongs_to :store
  has_many :cart_items


end
