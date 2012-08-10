class CreateDebits < ActiveRecord::Migration
  def change
    create_table :debits do |t|
      t.integer :member_id
      t.decimal :amount
      t.date :date_of_transaction

      t.timestamps
    end
  end
end
