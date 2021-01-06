require 'rails_helper'

RSpec.describe Store, type: :model do
  before(:each) do
    @store =  FactoryBot.create(:store) 
  end
  context 'validation test' do
    it 'valid store' do
      expect(@store.save).to eq true
    end

    it 'invalid store due to blank name' do
      @store.name = ''
      @store.save
      expect(@store.errors.messages).to have_key(:name)
      expect(@store.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'invalid store due to blank description' do
      @store.description = ''
      @store.save
      expect(@store.errors.messages).to have_key(:description)
      expect(@store.errors.messages[:description]).to eq ["can't be blank"]
    end

    it 'invalid store due to blank address' do
      @store.address = ''
      @store.save
      expect(@store.errors.messages).to have_key(:address)
      expect(@store.errors.messages[:address]).to eq ["can't be blank"]
    end
  end

end
