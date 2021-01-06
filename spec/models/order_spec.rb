require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do
    @courier =  FactoryBot.create(:courier) 
    @store = FactoryBot.create(:store)
    @user = FactoryBot.create(:user)
    @invoice =  FactoryBot.create(:invoice, user: @user) 
    @order = FactoryBot.create(:order, store: @store, invoice: @invoice, user: @user, courier: @courier)  

  end

  context 'validation test' do
    it 'valid order' do
      expect(@order.save).to eq true
    end

    it 'invalid because user blank' do
      @order.user = nil
      expect(@order.save).to eq false
      expect(@order.errors.messages).to have_key(:user)
      expect(@order.errors.messages[:user]).to eq ["must exist"]
    end

    it 'invalid because courier blank' do
      @order.courier = nil
      expect(@order.save).to eq false
      expect(@order.errors.messages).to have_key(:courier)
      expect(@order.errors.messages[:courier]).to eq ["must exist"]
    end

    it 'invalid because store blank' do
      @order.store = nil
      expect(@order.save).to eq false
      expect(@order.errors.messages).to have_key(:store)
      expect(@order.errors.messages[:store]).to eq ["must exist"]
    end

    it 'valid because invoice is optional' do
      @order.invoice = nil
      expect(@order.save).to eq true
    end
  end

  context 'data relation test' do
    it 'should have relation to user' do
      expect(@order.user).to_not eq nil
      expect(@order.user.class).to eq User
      expect(@order.user.email).to eq @user.email
    end

    it 'should have relation to courier' do
      expect(@order.courier).to_not eq nil
      expect(@order.courier.class).to eq Courier
      expect(@order.courier.name).to eq @courier.name
    end

    it 'should have relation to store' do
      expect(@order.store).to_not eq nil
      expect(@order.store.class).to eq Store
      expect(@order.store.name).to eq @store.name
    end

    it 'should have relation to invoice' do
      expect(@order.invoice).to_not eq nil
      expect(@order.invoice.class).to eq Invoice
      expect(@order.invoice.id).to eq @invoice.id
    end
  end

  context 'callback methods' do
    it 'should call set total after save' do
      @product = FactoryBot.create(:product, store: @store)
      @variant =  FactoryBot.create(:variant) 
      @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
      @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
      @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, discount: 10, product: @product)
      @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, discount: 10, product: @product)

      FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
      FactoryBot.create(:product_variant_detail, product_variant: @product_variant2, variant: @variant, variant_option: @variant_option2)
      
      @order_item1 = FactoryBot.create(:order_item, quantity: 1, price: @product_variant1.price, discount: @product_variant1.discount, order: @order, product_variant: @product_variant1 )
      @order_item2 = FactoryBot.create(:order_item, quantity: 1, price: @product_variant2.price, discount: @product_variant2.discount, order: @order, product_variant: @product_variant2 )
      @order.order_items << @order_item1
      @order.order_items << @order_item2
      @order.delivery_cost = 30000
      @order.save
      expect(@order.total_price).to eq 270000
      expect(@order.total).to eq 300000
    end
  end
end