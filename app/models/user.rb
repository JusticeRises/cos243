class User < ActiveRecord::Base
  #has_secure_password
  ##attr_accessor :name, :password, :password_confirmation
  ##before_save { self.password = self.password_confirmation }
  attr_reader :username, :password, :confirmation
  attr_writer :username, :password, :confirmation
  validates :username, presence: true
  validates :password, presence: true
  validates :confirmation, presence: true
end
