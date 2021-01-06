class Product < ApplicationRecord

  searchkick searchable: [:name,  :description, :store_name, :variant_name],
             filterable: [:store_id, :store_name]


  belongs_to :store
  has_many   :product_variants

  validates :name, :description, presence: true

  def search_data
    attrs = attributes.dup.except(:created_at, :updated_at)
    relational = {
      store_name: store.name,
      variant_name: product_variants.map(&:variant_name)
    }
    attrs.merge! relational
  end


end
