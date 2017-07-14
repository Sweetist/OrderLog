class User < ApplicationRecord
  
  has_many :orders, dependent: :nullify

  #acts_as_token_authenticatable
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable#,
          #:confirmable, :omniauthable
  
  #include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  # Use this before callback to set up User access_token.

  # If the user has no access_token, generate one.

end