require 'rails_helper'

RSpec.describe Courier, type: :model do
  before(:each) do
    @courier =  FactoryBot.create(:courier) 
  end
  context 'validation test' do
    it 'valid courier' do
      expect(@courier.save).to eq true
    end

    it 'invalid because name blank' do
      @courier.name = ""
      expect(@courier.save).to eq false
      expect(@courier.errors.messages).to have_key(:name)
      expect(@courier.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'invalid becasue price blank' do
      @courier.price = nil
      expect(@courier.save).to eq false
      expect(@courier.errors.messages).to have_key(:price)
      expect(@courier.errors.messages[:price]).to eq ["can't be blank"]
    end

  end
end
