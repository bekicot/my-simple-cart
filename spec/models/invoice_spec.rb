require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @invoice =  FactoryBot.create(:invoice, user: @user) 
  end
  context 'validation test' do
    it 'valid invoice' do
      expect(@invoice.save).to eq true
    end

    it 'invalid store due to user_id blank' do
      @invoice.user_id = ''
      expect(@invoice.save).to eq false
      expect(@invoice.errors.messages).to have_key(:user_id)
      expect(@invoice.errors.messages[:user_id]).to eq ["can't be blank"]
    end
  end

  context 'data relation test with belongs_to user' do
    it 'valid because have user connected' do
      expect(@invoice.save).to eq true
      expect(@invoice.user.email).to eq @user.email
    end

    it 'invalid because have no user connected' do
      @invoice.user = nil
      expect(@invoice.save).to eq false
    end
  end

  context 'data relation test with has_many orders' do
    it 'should have [] orders' do
      expect(@invoice.orders).to eq []
    end

    it 'should have data orders' do
      @store = FactoryBot.create(:store)
      @courier = FactoryBot.create(:courier)
      @order = FactoryBot.create(:order, store: @store, invoice: @invoice, user: @user, courier: @courier)
      expect(@invoice.orders).to_not eq []
      expect(@invoice.orders.first.id).to eq @order.id
    end
  end

end
