class Player < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  has_many :matches
  has_many :player_matches
  
  validates :user, presence: true
  validates :contest, presence: true
  
  validates :name, presence: true, length: {minimum: 1}
  validates_uniqueness_of :name
  validate :file_exists?
  
  validates :description, presence: true, length: {minimum: 1}
  
  before_destroy :destroyAction
  
  include Uploadable
  
   def file_exists?
    if self.file_location.nil? or !File.exist?(self.file_location)
      errors.add(:file_location, "File location must contain a file.")
    end
  end
  
  def destroyAction
    File.delete(self.file_location)
  end
  
end
