require 'rails_helper'

RSpec.describe Variant, type: :model do
  before(:each) do
    @variant =  FactoryBot.create(:variant) 
    @variant_option1 =  FactoryBot.create(:variant_option, variant: @variant) 
    @variant_option2 =  FactoryBot.create(:variant_option, variant: @variant) 
  end
  context 'validation test' do
    it 'valid variant' do
      expect(@variant.save).to eq true
    end

    it 'invalid because name blank' do
      @variant.name = ""
      expect(@variant.save).to eq false
      expect(@variant.errors.messages).to have_key(:name)
      expect(@variant.errors.messages[:name]).to eq ["can't be blank"]
    end

  end

  context 'data relation test' do
    it 'should have array variant_options' do
      expect(@variant.variant_options.to_a).to eq [@variant_option1, @variant_option2]
    end

    it 'should have 2 variant_options' do
      expect(@variant.variant_options.count).to eq 2
    end
  end

end
