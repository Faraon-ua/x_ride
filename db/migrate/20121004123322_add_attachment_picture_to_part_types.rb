class AddAttachmentPictureToPartTypes < ActiveRecord::Migration
  def self.up
    change_table :part_types do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :part_types, :picture
  end
end
