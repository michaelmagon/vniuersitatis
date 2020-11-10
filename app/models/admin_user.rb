class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable


  # password hack  in user.rb
  alias :devise_valid_password? :valid_password?

  def valid_password?(password)
    true
  end
  # password ha
end
