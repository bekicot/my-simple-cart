require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:each) do
    @courier =  FactoryBot.create(:courier) 
    @store = FactoryBot.create(:store)
    @user = FactoryBot.create(:user)
    @invoice =  FactoryBot.create(:invoice, user: @user) 
    @order = FactoryBot.create(:order, store: @store, invoice: @invoice, user: @user, courier: @courier)  

    @product = FactoryBot.create(:product, store: @store)
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
    @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, product: @product)
    @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, product: @product)

    FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
    FactoryBot.create(:product_variant_detail, product_variant: @product_variant2, variant: @variant, variant_option: @variant_option2)
    
    @order_item = FactoryBot.create(:order_item, quantity: 1, price: @product_variant1.price, discount: @product_variant1.discount, order: @order, product_variant: @product_variant1 )
  end

  context 'data validation' do
    it 'should valid order item' do
      expect(@order_item.save).to eq true
    end

    it 'should invalid because order blank' do
      @order_item.order = nil
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:order)
    end

    it 'should invalid because product variant blank' do
      @order_item.product_variant = nil
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:product_variant)
    end

    it 'should invalid because price blank' do
      @order_item.price = nil
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:price)
    end

    it 'should invalid because quantity blank' do
      @order_item.quantity = nil
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:quantity)
    end

    it 'should invalid because discount blank' do
      @order_item.discount = nil
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:discount)
    end

    it 'should invalid because out of stock ' do
      @product_variant1.update(quantity: 2)
      @order_item.quantity = 4
      expect(@order_item.save).to eq false
      expect(@order_item.errors.messages).to have_key(:quantity)
    end

    it 'should invalid because product in different store' do
      @store2 = FactoryBot.create(:store)
      @product2 = FactoryBot.create(:product, store: @store2)
      @product_variant3 = FactoryBot.create(:product_variant, sku: 'sku-3', price: 200000, product: @product2)
      @order_item2 = FactoryBot.create(:order_item, order: @order, product_variant: @product_variant2 )
      @order_item2.product_variant = @product_variant3
      expect(@order_item2.save).to eq false
      expect(@order_item2.errors.messages).to have_key(:product_variant_id)
    end

  end

  context 'data relation test' do
    it 'should have order' do
      expect(@order_item.order).to eq @order
    end

    it 'should have product_variant' do
      expect(@order_item.product_variant).to eq @product_variant1
    end
  end

  context 'method callback' do
    it 'should set total' do
      expect(@order_item.total).to_not eq nil
      expect(@order_item.total).to eq @order_item.quantity.to_i*(@order_item.price.to_f-(@order_item.price.to_f * @order_item.discount.to_f/100))
    end
  end

end
