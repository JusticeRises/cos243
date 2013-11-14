class Referee < ActiveRecord::Base
  belongs_to :user
  
  has_many :contests
  has_many :matches, as: :manager
  
  validates :players_per_game, presence: true, :inclusion => 1..10
  
  validates :name, presence: true, length: {minimum: 1}
  validates :rules_url, presence: true, length: {minimum: 1}
  validates :file_location, presence: true, length: {minimum: 1}
  
  validates_format_of :rules_url, :with => URI::regexp
  
  def upload=(uploaded_io)
    if uploaded_io.nil?
      # problem -- deal with later
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
      file_location = Rails.root.join('code',
                                      'referees',
                                       Rails.env,
                                       #Time.now.to_s + current_user.id.to_s).to_s
                                       time_no_spaces).to_s
      IO::copy_stream(uploaded_io, file_location)
      self.file_location = file_location
    end
  end  
end
