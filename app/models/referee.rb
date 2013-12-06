class Referee < ActiveRecord::Base
  ##https://github.com/adzap/validates_timeliness
  
  belongs_to :user
  
  has_many :contests
  has_many :matches, as: :manager
  
  validates :players_per_game, presence: true, :inclusion => 1..10
  validates_numericality_of :players_per_game, :only_integer => true
  
  validates :name, presence: true, length: {minimum: 1}
  validates_uniqueness_of :name
  
  validates :rules_url, presence: true, length: {minimum: 1}
  validates :file_location, presence: true, length: {minimum: 1}
  validate :file_exists?
  
  validates_format_of :rules_url, :with => URI::regexp
  
  before_destroy :destroyAction
  
  def destroyAction
    File.delete(self.file_location)
  end
  
  def file_exists?
    if self.file_location.nil? or !File.exist?(self.file_location)
      errors.add(:file_location, "File location must contain a file.")
    end
  end
  
  def referee 
    self 
  end
  
  include Uploadable
end
