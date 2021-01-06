require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user =  FactoryBot.create(:user) 
  end
  context 'validation test' do
    it 'valid user attributes' do
      expect(@user.save).to eq(true)
    end

    it 'invalid due to blank name' do
      @user.name = ''
      @user.save
      expect(@user.errors.messages).to have_key(:name)
    end

    it 'invalid due to not email format' do
      @user.email = 'email@email'
      @user.save
      expect(@user.errors.messages).to have_key(:email)
      expect(@user.errors.messages[:email]).to eq ['is not an email']
    end

    it 'invalid due to blank email' do
      @user.email = ''
      @user.save
      expect(@user.errors.messages).to have_key(:email)
      expect(@user.errors.messages[:email]).to eq ["can't be blank"]
    end

    it 'invalid due to blank password' do
      @user.password = ''
      @user.save
      expect(@user.errors.messages).to have_key(:password)
      expect(@user.errors.messages[:password]).to eq ["can't be blank"]
    end

    it 'invalid due to not match password confirmation' do
      @user.password_confirmation = 'test123'
      @user.save
      expect(@user.errors.messages).to have_key(:password_confirmation)
      expect(@user.errors.messages[:password_confirmation]).to eq ["doesn't match Password"]
    end
  end

  context 'data test' do
    it 'uid should be set by email beacuse provider is email' do
      @user.save
      expect(@user.uid).to eq @user.email
    end

    it 'uid should not be email when provider is social media' do
      user = FactoryBot.create(:user, provider: 'facebook', uid: 'facebook-xxx-uid')
      user.save
      expect(user.uid).to_not eq(user.email)
    end

  end
end
