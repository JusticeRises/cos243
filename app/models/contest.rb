class Contest < ActiveRecord::Base
  belongs_to :referee
  belongs_to :user
  
  has_many :players
  has_many :matches
  
  validates :referee, presence: true
  validates :user, presence: true
  
  validates :name, presence: true
  validates_uniqueness_of :name
  
  validates :deadline, presence: true
  validates :contest_type, presence: true
  validates :start, presence: true
  
  validates_datetime :start, :on_or_after => :now
  validates_datetime :deadline, :on_or_before => lambda { |record| record.start }
end
