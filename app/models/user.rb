class User < ActiveRecord::Base
  #attr_accessor :name, :password, :password_confirmation
  #before_save { self.password = self.password_confirmation }
  attr_reader :username, :password, :password_confirmation
  attr_writer :username, :password, :password_confirmation
end
