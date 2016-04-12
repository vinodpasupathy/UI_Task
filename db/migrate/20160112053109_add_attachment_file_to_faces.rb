class AddAttachmentFileToFaces < ActiveRecord::Migration
  def self.up
    change_table :faces do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :faces, :file
  end
end
