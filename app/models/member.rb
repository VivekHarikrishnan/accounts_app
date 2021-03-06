class Member < ActiveRecord::Base
  QUALIFICATIONS = {"Not Applicable" => "NA", "Below SSLC" => "BSSLC", "SSLC" => "SSLC",
                  "HSC" => "HSC", "B.A" => "BA", "M.A" => "MA", "B.Sc" => "BSC", "M.sc" => "MSC",
                  "B.Com" => "BCOM", "M.Com" => "MCOM", "Diplomo" => "DIPLOMO", "B.E/B.Tech" => "BE/BTECH",
                  "BCA" => "BCA", "MCA" => "MCA","BBA" => "BBA", "MBA" => "MBA", "Others" => "OTHERS"}

  has_attached_file :photo, styles: {
    thumb: "100x100>",
    small: "400x400>"
  }
  
  attr_accessible :first_name, :last_name, :date_of_birth, :date_of_join, 
    :qualification, :address, :password, :password_confirmation, :photo

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

  has_many :credits, dependent: :destroy
  has_many :debits, dependent: :destroy
  has_many :repayments, dependent: :destroy

  def self.authenticate(username, password)
    member = find_by_first_name(username)
    member if member and member.authenticate(password)
  end

  def self.all
    find(:all, conditions: ["first_name != ?", "admin"], order: "first_name ASC")
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
    credit_amount - debit_amount + repaid_amount
  end

  def amount_to_repay
    debit_amount - repaid_amount
  end

  def repaid_amount
    total_amount = 0
    repayments.collect { |c| total_amount += c.amount }

    total_amount
  end
end
