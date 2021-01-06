require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

courir1 = Courier.create(name: 'JNE', price: 10000)
courir2 = Courier.create(name: 'JNT', price: 15000)
courir3 = Courier.create(name: 'SICEPAT', price: 20000)


store1 = Store.create(name: 'Adeeva Sport and co', description: 'Menjual barang olahraga dan akesesoris', address: 'Bandung')
store2 = Store.create(name: 'King of tshirt', description: 'rajanya kaos dan tshirt', address: 'Jakarta')
store3 = Store.create(name: 'Shoe da best', description: 'Sepatuku untuk kamu.', address: 'Medan')

#create variant data
size = Variant.create(name: 'Size')
color = Variant.create(name: 'Color')

#create variant options data for Color
shirt_color = []
shirt_color << VariantOption.create(name: 'Black', variant_id: color.id)
shirt_color << VariantOption.create(name: 'Red', variant_id: color.id)
shirt_color << VariantOption.create(name: 'White', variant_id: color.id)
shirt_color << VariantOption.create(name: 'Grey', variant_id: color.id)

#create variant options data for Size
shirt_size = []
shirt_size << VariantOption.create(name: 'S', variant_id: size.id)
shirt_size << VariantOption.create(name: 'M', variant_id: size.id)
shirt_size << VariantOption.create(name: 'L', variant_id: size.id)
shirt_size << VariantOption.create(name: 'XL', variant_id: size.id)
shirt_size << VariantOption.create(name: 'XXL', variant_id: size.id)

thisrt = ['V-Neck T-Shirt', 'Hoodie', 'Hoodie with Logo', 'Beanie', 'Hoodie with Pocket', 'Hoodie with Zipper', 'Long Sleeve Tee', 'Polo', 'Avenger T Shirt', 'Captain America Jacket'] 
sports = ['Jersey', 'running short', 'running tee', 'topi lari', 'Setelan Futsal', 'Baju sepeda']
shoes = ['Kickass Kicks', 'Little Goody New Shoes', 'Padded Room', 'Pair-a-Feet', 'Neat Feet', 'Oh Pair!', 'Foot Fetish', 'Down the Sole', 'Cute Boots', 'Elite Feet', 'Stadium Goods', 'Shoe Must Go On', 'Shoeless', 'Muse Shoe Studio']

shoes_size = []
shoes_size << VariantOption.create(name: '38', variant_id: size.id)
shoes_size << VariantOption.create(name: '39', variant_id: size.id)
shoes_size << VariantOption.create(name: '40', variant_id: size.id)
shoes_size << VariantOption.create(name: '41', variant_id: size.id)
shoes_size << VariantOption.create(name: '42', variant_id: size.id)
shoes_size << VariantOption.create(name: '43', variant_id: size.id)
shoes_size << VariantOption.create(name: '44', variant_id: size.id)

prices_option = [89000, 100000, 95000, 120000, 135000, 140000]

#create 5 products each store
1.upto(5) do |i|
  colors = shirt_color.sample(1 + rand(shirt_color.count))
  sizes = shirt_size.sample(1 + rand(shirt_color.count))

  product = Product.create(name: sports.sample, description: Faker::Quote.famous_last_words, store_id: store1.id) 
  colors.each do |color|
    sizes.each do |size|
      product_variant = product.product_variants.create(
        sku: "product-#{product.id}-#{color.name.downcase.parameterize}-#{size.name.downcase.parameterize}",
        price: prices_option.sample,
        quantity: 100, 
        discount: 0
      )
      product_variant_detail = ProductVariantDetail.create(
        variant_id: size.variant_id,
        product_variant_id: product_variant.id,
        variant_option_id: color.id
      )
      product_variant_detail = ProductVariantDetail.create(
        variant_id: size.variant_id,
        product_variant_id: product_variant.id,
        variant_option_id: size.id
      )

    end
  end
  end

  #create 5 products each store
  1.upto(5) do |i|
    colors = shirt_color.sample(1 + rand(shirt_color.count))
    sizes = shoes_size.sample(1 + rand(shirt_color.count))
  
    product = Product.create(name: shoes.sample, description: Faker::Quote.famous_last_words, store_id: store3.id) 
    colors.each do |color|
      sizes.each do |size|
        product_variant = product.product_variants.create(
          sku: "product-#{product.id}-#{color.name.downcase.parameterize}-#{size.name.downcase.parameterize}",
          price: prices_option.sample,
          quantity: 100, 
          discount: 0
        )
        product_variant_detail = ProductVariantDetail.create(
          variant_id: size.variant_id,
          product_variant_id: product_variant.id,
          variant_option_id: color.id
        )
        product_variant_detail = ProductVariantDetail.create(
          variant_id: size.variant_id,
          product_variant_id: product_variant.id,
          variant_option_id: size.id
        )
  
      end
    end
  end

   #create 5 products each store
   1.upto(5) do |i|
    colors = shirt_color.sample(1 + rand(shirt_color.count))
    sizes = shirt_size.sample(1 + rand(shirt_color.count))
  
    product = Product.create(name: thisrt.sample, description: Faker::Quote.famous_last_words, store_id: store2.id) 
    colors.each do |color|
      sizes.each do |size|
        product_variant = product.product_variants.create(
          sku: "product-#{product.id}-#{color.name.downcase.parameterize}-#{size.name.downcase.parameterize}",
          price: prices_option.sample,
          quantity: 100, 
          discount: 0
        )
        product_variant_detail = ProductVariantDetail.create(
          variant_id: size.variant_id,
          product_variant_id: product_variant.id,
          variant_option_id: color.id
        )
        product_variant_detail = ProductVariantDetail.create(
          variant_id: size.variant_id,
          product_variant_id: product_variant.id,
          variant_option_id: size.id
        )
  
      end
    end
  end

Product.reindex

