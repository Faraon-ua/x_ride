class AddRegionAndConditionToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :region, :string
    add_column :parts, :condition, :string
  end

  def self.down
    remove_column :parts, :region
    remove_column :parts, :condition
  end
end
