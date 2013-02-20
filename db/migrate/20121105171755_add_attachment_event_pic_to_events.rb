class AddAttachmentEventPicToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.has_attached_file :event_pic
    end
  end

  def self.down
    drop_attached_file :events, :event_pic
  end
end
