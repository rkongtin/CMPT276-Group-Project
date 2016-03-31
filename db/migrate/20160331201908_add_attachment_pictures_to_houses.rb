class AddAttachmentPicturesToHouses < ActiveRecord::Migration
  def self.up
    change_table :houses do |t|
      t.attachment :pictures
    end
  end

  def self.down
    remove_attachment :houses, :pictures
  end
end
