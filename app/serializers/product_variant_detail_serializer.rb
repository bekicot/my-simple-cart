class ProductVariantDetailSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.variant_option.name
  end
  
end
