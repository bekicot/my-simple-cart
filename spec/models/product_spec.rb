require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @store =  FactoryBot.create(:store) 
    @product = FactoryBot.create(:product, store: @store)
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
    @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, product: @product)
    @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, product: @product)

    FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
    FactoryBot.create(:product_variant_detail, product_variant: @product_variant2, variant: @variant, variant_option: @variant_option2)

  end
  context 'validation test' do
    it 'valid product' do
      expect(@product.save).to eq true
    end

    it 'invalid product because blank name' do
      @product.name = nil
      expect(@product.save).to eq false
    end

    it 'invalid product because blank description' do
      @product.description = nil
      expect(@product.save).to eq false
    end
  end

  context 'data relation' do
    it 'should have store' do
      expect(@product.store).to eq @store
    end

    it 'should have product variants' do
      expect(@product.product_variants.to_a).to eq [@product_variant1, @product_variant2]
    end
  end

end
