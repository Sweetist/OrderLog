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
  before_save :ensure_authentication_token

  # If the user has no access_token, generate one.
  def ensure_authentication_token
    if access_token.blank?
      self.access_token = generate_access_token
    end
  end

  private
    def generate_access_token
      loop do
        token = SecureRandom.base58(24)
        break token unless User.where(authentication_token: token).first
      end
    end
end