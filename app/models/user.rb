require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :photos
  has_many :comments
validates :first_name, :presence => true
validates :last_name, :presence => true

validates_uniqueness_of :first_name
validates_uniqueness_of :last_name

attr_accessor :password_confirmation
 validates_confirmation_of :password

def password 
  @password
end
def password=(pwd)
  @password = pwd
  return if pwd.blank?
  create_new_salt
  self.hashed_password = User.encrypted_password(self.password, self.salt)
end
def create_new_salt
  self.salt = self.object_id.to_s + rand.to_s
end
def self.encrypted_password(password, salt) 
  string_to_hash = password + "wibble" + salt
   Digest::SHA1.hexdigest(string_to_hash)
end
end
