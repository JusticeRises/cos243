class Contest < ActiveRecord::Base
  belongs_to :referee
  belongs_to :user
  
  has_many :players
  has_many :matches
  
  validates :referee, presence: true
  validates :user, presence: true
end
