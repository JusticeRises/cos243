class User < ActiveRecord::Base
  has_secure_password
  #attr_accessor :username, :password, :confirmation
  ##before_save { self.password = self.password_confirmation }
  #attr_reader :username, :password, :confirmation
  #attr_writer :username, :password, :confirmation
  #validates :username, presence: true
  #validates :password, presence: true
  #validates :confirmation, presence: true
  #validates_format_of :email
  #  :with => /^(+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates :username, presence: true 
  #validates :username, presence: true 
  
  validates_length_of :username, :maximum => 25
  validates_uniqueness_of :username
  
  validates :email, presence: true
  validates_format_of :email, :with =>  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  

 
  
  #### Jeremiah 29:11 ####
  #For I know the plans I have for you,” declares the Lord, “plans to prosper you and not to harm you, plans to give you hope and a future.#
  
end
