class Repayment < ActiveRecord::Base
  attr_accessible :amount, :date_of_transaction, :member_id

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates :member_id, presence: true
  validates :date_of_transaction, presence: true

  belongs_to :member
  alias_attribute :dot, :date_of_transaction
end
