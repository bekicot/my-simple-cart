class ProductSearch

  attr_reader :query, :options

  def initialize(query:nil, options: {})
    @query = query.presence || "*"
    @options = options
  end

  def search
    constraints = {}
    constraints[:where] = where
    constraints[:order] = order
    constraints[:includes] = [:store, :product_variants => [:product_variant_details => :variant_option]]
    Product.search(query, constraints)
  end

  def where
    where = {}
    if options[:store_name].present?
      where['store_name'] = options[:store_name]
    end
    if options[:store_id].present?
      where['store_id'] = options[:store_id]
    end
    where
  end

  def order
    if options[:sort_attribute].present?
      order = options[:sort_order].presence || :asc
      { options[:sort_attribute] => order }
    else
      { }
    end
  end
end
