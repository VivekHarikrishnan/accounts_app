class CreateRepayments < ActiveRecord::Migration
  def change
    create_table :repayments do |t|
      t.integer :member_id
      t.decimal :amount
      t.date :date_of_transaction

      t.timestamps
    end
  end
end
