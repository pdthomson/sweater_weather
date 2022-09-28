class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_uniqueness_of :api_key
  validates_presence_of :password_digest

  has_secure_password 

  before_create do 
    self[:api_key] = random_key
  end

  def random_key
    SecureRandom.hex(13)
  end
end
