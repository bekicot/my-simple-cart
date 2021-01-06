class OrderSerializer < ActiveModel::Serializer
  
  attributes :id, :store, :total, :status, :delivery_cost, :courier_name, :order_items
  belongs_to :store

  def courier_name
    object.courier.name
  end

end
