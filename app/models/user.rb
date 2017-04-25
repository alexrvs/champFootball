require 'base64'

class User < ApplicationRecord


  before_save {self.email = email.downcase}
  before_create :create_remember_token

  validates :first_name, :last_name, presence: true, length: {minimum: 4, maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

   has_secure_password
   validates :password, length: {minimum: 6}, on: :create


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.from_omniauth(auth)

    where(provider: auth.provider,facebook_id: auth.uid).first_or_create do |user|
      user.facebook_id = auth.uid
      user.email = auth.info.email
      # user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.image = auth.info.image
    end

  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
