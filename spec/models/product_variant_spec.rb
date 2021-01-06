require 'rails_helper'

RSpec.describe ProductVariant, type: :model do
  before(:each) do
    @store =  FactoryBot.create(:store) 
    @product = FactoryBot.create(:product, store: @store)
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
    @product_variant = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, product: @product)
    FactoryBot.create(:product_variant_detail, product_variant: @product_variant, variant: @variant, variant_option: @variant_option1)
    FactoryBot.create(:product_variant_detail, product_variant: @product_variant, variant: @variant, variant_option: @variant_option2)

  end
  context 'validation test' do
    it 'valid product variant' do
      expect(@product_variant.save).to eq true
    end

    it 'invalid because sku blank' do
      @product_variant.sku = nil
      expect(@product_variant.save).to eq false
      expect(@product_variant.errors.messages).to have_key(:sku)
      expect(@product_variant.errors.messages[:sku]).to eq ["can't be blank"]
    end

    it 'invalid because price blank' do
      @product_variant.price = nil
      expect(@product_variant.save).to eq false
      expect(@product_variant.errors.messages).to have_key(:price)
      expect(@product_variant.errors.messages[:price]).to eq ["can't be blank"]
    end

    it 'invalid because quantity blank' do
      @product_variant.quantity = nil
      expect(@product_variant.save).to eq false
      expect(@product_variant.errors.messages).to have_key(:quantity)
      expect(@product_variant.errors.messages[:quantity]).to eq ["can't be blank"]
    end

  end

  context 'data relation test' do
    it 'should have connection to product' do
      expect(@product_variant.product).to eq @product
    end

    it 'should have variant_details' do
      expect(@product_variant.product_variant_details.count).to eq 2
    end
  end

  context 'method test' do
    it 'return variant name' do
      expect(@product_variant.variant_name).to eq "#{@variant_option1.name}-#{@variant_option2.name}"
    end
  end

end
