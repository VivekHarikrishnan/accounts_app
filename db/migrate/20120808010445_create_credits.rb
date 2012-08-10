class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :member_id
      t.date :date_of_transaction
      t.decimal :amount

      t.timestamps
    end
  end
end
