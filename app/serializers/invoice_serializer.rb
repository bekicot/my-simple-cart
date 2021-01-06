class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :pay_status, :pay_at, :order_date

  has_many :orders, serializer: OrderSerializer

  def order_date
    object.created_at
  end

end
