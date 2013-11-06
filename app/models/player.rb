class Player < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  has_many :matches
  has_many :player_matches
  
  validates :user, presence: true
  validates :contest, presence: true
end
