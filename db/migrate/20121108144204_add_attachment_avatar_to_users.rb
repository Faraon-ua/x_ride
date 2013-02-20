class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.has_attached_file :avatar
    end
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :uid, :string
  end

  def self.down
    drop_attached_file :users, :avatar
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :uid
  end
end
