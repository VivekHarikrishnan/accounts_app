class Member < ActiveRecord::Base
  QUALIFICATIONS = {"Not Applicable" => "NA", "Below SSLC" => "BSSLC", "SSLC" => "SSLC",
                  "HSC" => "HSC", "B.A" => "BA", "M.A" => "MA", "B.Sc" => "BSC", "M.sc" => "MSC",
                  "B.Com" => "BCOM", "M.Com" => "MCOM", "Diplomo" => "DIPLOMO", "B.E/B.Tech" => "BE/BTECH",
                  "BCA" => "BCA", "MCA" => "MCA","BBA" => "BBA", "MBA" => "MBA", "Others" => "OTHERS"}
  
  attr_accessible :first_name, :last_name, :date_of_birth, :date_of_join, :qualification, :address, :password, :password_confirmation

  alias_attribute :dob, :date_of_birth
  alias_attribute :doj, :date_of_join

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true, uniqueness: { scope: :first_name }
  validates :date_of_birth, presence: true
  validates :date_of_join, presence: true
  validates :address, presence: true
  validates :qualification, presence: true

  before_save { self.qualification = self.qualification.downcase }

  has_many :credits
  has_many :debits

  def self.authenticate(username, password)
    member = find_by_first_name(username)
    member if member and member.authenticate(password)
  end

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

  def self.all
    find(:all, conditions: ["first_name != ?", "admin"], order: "first_name ASC")
  end

  def credit_amount
    total_amount = 0
    credits.collect { |c| total_amount += c.amount }

    total_amount
  end

  def debit_amount
    total_amount = 0
    debits.collect { |c| total_amount += c.amount }

    total_amount
  end

  def balance_amount
    credit_amount - debit_amount
  end
end
