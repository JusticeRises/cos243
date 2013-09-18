class User < ActiveRecord::Base
  #attr_accessor :name, :password, :password_confirmation
  #before_save { self.password = self.password_confirmation }
  attr_reader :username, :password, :confirmation
  attr_writer :username, :password, :confirmation
end
