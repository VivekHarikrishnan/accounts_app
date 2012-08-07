class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.date :date_of_join
      t.string :qualification
      t.text :address
      t.timestamps
    end
  end
end
