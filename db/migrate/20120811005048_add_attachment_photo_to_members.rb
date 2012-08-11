class AddAttachmentPhotoToMembers < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :members, :photo
  end
end
