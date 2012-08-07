class Member < ActiveRecord::Base
  QUALIFICATIONS = {"Not Applicable" => "NA", "Below SSLC" => "BSSLC", "SSLC" => "SSLC",
                  "HSC" => "HSC", "B.A" => "BA", "M.A" => "MA", "B.Sc" => "BSC", "M.sc" => "MSC",
                  "B.Com" => "BCOM", "M.Com" => "MCOM", "Diplomo" => "DIPLOMO", "B.E/B.Tech" => "BE/BTECH",
                  "BCA" => "BCA", "MCA" => "MCA","BBA" => "BBA", "MBA" => "MBA", "Others" => "OTHERS"}
  
  attr_accessible :first_name, :last_name, :date_of_birth, :date_of_join, :qualification, :address

  alias_attribute :dob, :date_of_birth
  alias_attribute :doj, :date_of_join

  validates :first_name, presence: true
  validates :last_name, presence: true, uniqueness: { scope: :first_name }
  validates :date_of_birth, presence: true
  validates :date_of_join, presence: true
  validates :address, presence: true
  validates :qualification, presence: true

  before_save { self.qualification = self.qualification.downcase }

  def to_s
    "#{self.first_name} #{self.last_name}"
  end

  def formatted_dob
    read_attribute(:date_of_birth).strftime("%d %b %Y")
  end

  def formatted_doj
    read_attribute(:date_of_join).strftime("%d %b %Y")
  end
  
  def formatted_qualification
    qualification_string = ""
    QUALIFICATIONS.each { |key, value| qualification_string = key if self.qualification == value.downcase  }

    qualification_string
  end
end
