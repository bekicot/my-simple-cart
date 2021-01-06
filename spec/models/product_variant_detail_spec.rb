require 'rails_helper'

RSpec.describe ProductVariantDetail, type: :model do
  before(:each) do
    @store =  FactoryBot.create(:store) 
    @product = FactoryBot.create(:product, store: @store)
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
    @product_variant1 = FactoryBot.create(:product_variant, sku: 'sku-1', price: 200000, product: @product)
    @product_variant2 = FactoryBot.create(:product_variant, sku: 'sku-2', price: 100000, product: @product)

    @variant_detail = FactoryBot.create(:product_variant_detail, product_variant: @product_variant1, variant: @variant, variant_option: @variant_option1)
  end
  context 'validation test' do
    it 'valid variant detail' do
      expect(@variant_detail.save).to eq true
    end

    it 'invalid because product_variant blank' do
      @variant_detail.product_variant = nil
      expect(@variant_detail.save).to eq false
      expect(@variant_detail.errors.messages).to have_key(:product_variant)
      expect(@variant_detail.errors.messages[:product_variant]).to eq ["must exist"]
    end

    it 'invalid because variant blank' do
      @variant_detail.variant = nil
      expect(@variant_detail.save).to eq false
      expect(@variant_detail.errors.messages).to have_key(:variant)
      expect(@variant_detail.errors.messages[:variant]).to eq ["must exist"]
    end

    it 'invalid because variant_option blank' do
      @variant_detail.variant_option = nil
      expect(@variant_detail.save).to eq false
      expect(@variant_detail.errors.messages).to have_key(:variant_option)
      expect(@variant_detail.errors.messages[:variant_option]).to eq ["must exist"]
    end

  end

  context 'data relation test' do
    it 'should have variant_option' do
      expect(@variant_detail.variant_option).to eq @variant_option1
    end

    it 'should have product_variant' do
      expect(@variant_detail.product_variant).to eq @product_variant1
    end

    it 'should have variant' do
      expect(@variant_detail.variant).to eq @variant
    end
    
    
  end
end
