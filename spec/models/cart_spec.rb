require 'rails_helper'

RSpec.describe Cart, type: :model do
  before(:each) do
    @store = FactoryBot.create(:store)
    @user = FactoryBot.create(:user)
    @cart = FactoryBot.create(:cart, store: @store, user: @user)
  end

  context 'validation test' do
    it 'valid cart' do
      expect(@cart.save).to eq true
    end

    it 'invalid because user blank' do
      @cart.user = nil
      expect(@cart.save).to eq false
      expect(@cart.errors.messages).to have_key(:user)
    end

    it 'invalid because store blank' do
      @cart.store = nil
      expect(@cart.save).to eq false
      expect(@cart.errors.messages).to have_key(:store)
    end
  end

  context 'data relation test' do
    it 'should have relation to user' do
      expect(@cart.user).to_not eq nil
      expect(@cart.user.class).to eq User
      expect(@cart.user.email).to eq @user.email
    end

    it 'should have relation to store' do
      expect(@cart.store).to_not eq nil
      expect(@cart.store.class).to eq Store
      expect(@cart.store.name).to eq @store.name
    end

    it 'should have relation to cart_items' do
      expect(@cart.cart_items).to eq []
    end
  end

  context 'methods' do
    before(:each) do
      @product = FactoryBot.create(:product, store: @store)
      @variant =  FactoryBot.create(:variant) 
      @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
      @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
      @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, discount: 10, product: @product)
      @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, discount: 10, product: @product)

      FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
      FactoryBot.create(:product_variant_detail, product_variant: @product_variant2, variant: @variant, variant_option: @variant_option2)
    end 
    it 'success add_product' do
      Cart.add_product(@user, @product_variant1, 1, 'notes')
      expect(@cart.cart_items.first.product_variant).to eq @product_variant1
      expect(@cart.cart_items.first.notes).to eq 'notes'
    end

    it 'should could not be deleted because have cart_items' do
      Cart.add_product(@user, @product_variant1, 1, 'notes')
      id = @cart.id
      @cart.delete_me_if_no_item
      cart = Cart.find(id) rescue nil
      expect(@cart).to_not eq nil
    end

    it 'should could be deleted because have no cart_items' do
      id = @cart.id
      @cart.delete_me_if_no_item
      cart = Cart.find(id) rescue nil
      expect(cart).to eq nil
    end

  end
end
