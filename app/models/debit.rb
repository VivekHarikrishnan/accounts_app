class Debit < ActiveRecord::Base
  attr_accessible :amount, :date_of_transaction, :member_id

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates :member_id, presence: true
  validates :date_of_transaction, presence: true
  validate :debit_amount_with_credit_amount

  belongs_to :member
  alias_attribute :dot, :date_of_transaction

  def formatted_dot
    read_attribute(:date_of_transaction).strftime("%d %b %Y")
  end

  def debit_amount_with_credit_amount
    total_amount_creditted = Credit.total_amount

    errors.add(:amount, "is invalid. No enough amount to debit (available amount: #{CURRENCY} #{Credit.total_amount})") if amount and amount > total_amount_creditted
  end
end
