class AddAdminMember < ActiveRecord::Migration
  def up
    Member.create({
        first_name: "admin", last_name: "user",
        date_of_birth: "2012-12-12", date_of_join: "2012-12-12",
        qualification: Member::QUALIFICATIONS["Not Applicable"], address: "address",
        password: "password", password_confirmation: "password"})
  end

  def down
    Member.find_by_first_name("admin").destroy
  end
end
