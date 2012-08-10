class Credit < ActiveRecord::Base
  attr_accessible :amount, :date_of_transaction, :member_id
  alias_attribute :dot, :date_of_transaction

  validates :member_id, presence: true
  validates :date_of_transaction, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.0 }

  belongs_to :member

  def formatted_dot
    read_attribute(:date_of_transaction).strftime("%d %b %Y")
  end

  def self.total_amount
    amount = 0
    Member.all.collect {|member| amount += member.credit_amount}

    amount
  end
end
