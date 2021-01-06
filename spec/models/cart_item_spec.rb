require 'rails_helper'

RSpec.describe CartItem, type: :model do
  before(:each) do
    @store = FactoryBot.create(:store)
    @user = FactoryBot.create(:user)
    @cart = FactoryBot.create(:cart, store: @store, user: @user)

    @product = FactoryBot.create(:product, store: @store)
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
    @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, discount: 10, product: @product)
    @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, discount: 10, product: @product)

    FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
    FactoryBot.create(:product_variant_detail, product_variant: @product_variant2, variant: @variant, variant_option: @variant_option2)
    
    @cart_item1 = FactoryBot.create(:cart_item, cart: @cart, product_variant: @product_variant1, quantity: 2, price: @product_variant1.price, discount: @product_variant1.discount )
  end

  context 'validation test' do
    it 'valid cart' do
      expect(@cart_item1.save).to eq true
    end

    it 'invalid because cart blank' do
      @cart_item1.cart = nil
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:cart)
    end

    it 'invalid because product_variant blank' do
      @cart_item1.product_variant = nil
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:product_variant)
    end

    it 'should invalid because price blank' do
      @cart_item1.price = nil
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:price)
    end

    it 'should invalid because quantity blank' do
      @cart_item1.quantity = nil
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:quantity)
    end

    it 'should invalid because discount blank' do
      @cart_item1.discount = nil
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:discount)
    end

    it 'should invalid because out of stock ' do
      @product_variant1.update(quantity: 2)
      @cart_item1.quantity = 4
      expect(@cart_item1.save).to eq false
      expect(@cart_item1.errors.messages).to have_key(:quantity)
    end
  end

  context 'data relation test' do
    it 'should have relation to cart' do
      expect(@cart_item1.cart).to_not eq nil
      expect(@cart_item1.cart.class).to eq Cart
    end

    it 'should have relation to product variant' do
      expect(@cart_item1.product_variant).to_not eq nil
      expect(@cart_item1.product_variant.class).to eq ProductVariant
      expect(@cart_item1.product_variant).to eq @product_variant1
    end

  end

  context 'methods' do
    it 'should set total' do
      expect(@cart_item1.total).to eq 360000
    end
    
    it 'cart should not be deleted' do
      id = @cart.id
      @cart_item2 = FactoryBot.create(:cart_item, cart: @cart, product_variant: @product_variant2, quantity: 1, price: @product_variant2.price, discount: @product_variant2.discount )
      @cart_item1.delete_with_parent_if_no_child
      cart = Cart.find(id) rescue nil
      expect(cart).to_not eq nil
      expect(cart.id).to eq id
    end

    it 'cart should be deleted' do
      id = @cart.id
      @cart_item1.delete_with_parent_if_no_child
      cart = Cart.find(id) rescue nil
      expect(cart).to eq nil
    end

  end
end
