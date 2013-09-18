class User < ActiveRecord::Base
  attr_accessor :name, :password, :password_confirmation
  before_save { self.password = self.password_confirmation }
end
