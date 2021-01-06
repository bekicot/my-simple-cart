require 'rails_helper'

RSpec.describe VariantOption, type: :model do
  before(:each) do
    @variant =  FactoryBot.create(:variant) 
    @variant_option =  FactoryBot.create(:variant_option, variant: @variant) 
  end
  context 'validation test' do
    it 'valid variant option' do
      expect(@variant_option.save).to eq true
    end

    it 'invalid because name blank' do
      @variant_option.name = ""
      expect(@variant_option.save).to eq false
      expect(@variant_option.errors.messages).to have_key(:name)
      expect(@variant_option.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'invalid because variant blank' do
      @variant_option.variant = nil
      expect(@variant_option.save).to eq false
      expect(@variant_option.errors.messages).to have_key(:variant)
      expect(@variant_option.errors.messages[:variant]).to eq ["must exist"]
    end

  end

  context 'data relation test' do
    it 'should have variant' do
      expect(@variant_option.variant.class).to eq Variant
      expect(@variant_option.variant.id).to eq @variant.id
    end
  end
end
