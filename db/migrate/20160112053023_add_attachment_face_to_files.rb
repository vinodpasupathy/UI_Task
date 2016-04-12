class AddAttachmentFaceToFiles < ActiveRecord::Migration
  def self.up
    change_table :files do |t|
      t.attachment :face
    end
  end

  def self.down
    remove_attachment :files, :face
  end
end
