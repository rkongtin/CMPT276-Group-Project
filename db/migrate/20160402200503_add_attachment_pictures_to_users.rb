class AddAttachmentPicturesToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :pictures
    end
  end

  def self.down
    remove_attachment :users, :pictures
  end
end
