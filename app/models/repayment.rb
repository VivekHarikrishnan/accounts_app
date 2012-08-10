class Repayment < ActiveRecord::Base
  attr_accessible :amount, :date_of_transaction, :member_id

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates :member_id, presence: true
  validates :date_of_transaction, presence: true
  validate :with_amount_to_repay

  belongs_to :member
  alias_attribute :dot, :date_of_transaction

  def with_amount_to_repay
    if member_id and amount
      errors.add(:amount, "exceeds. You can pay less than or equal
       to amount to be paid (#{CURRENCY} #{member.amount_to_repay})") if amount > member.amount_to_repay      
    end
  end

  def formatted_dot
    read_attribute(:date_of_transaction).strftime("%d %b %Y")
  end
end
