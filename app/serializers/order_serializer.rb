class OrderSerializer < ActiveModel::Serializer
  
  attributes :id, :store, :total, :status, :delivery_cost, :courier_name
  belongs_to :store
  has_many :order_items

  def courier_name
    object.courier.name
  end

end
