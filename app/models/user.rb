# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models #added this line to extend devise model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  has_many :carts
  has_many :orders
  has_many :invoices
  
  validates :name, presence: true

  def self.from_social_provider(provider, user_params)
    where( uid: user_params[:uid], provider: provider).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

end
