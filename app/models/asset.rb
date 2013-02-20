class Asset < ActiveRecord::Base
  attr_accessible :description, :title, :url, :asset_content_type, :asset_file_name, :asset_file_size, :asset_updated_at, :part_id, :asset
  belongs_to :part
  has_attached_file :asset, :styles => { :large => "640x480", :medium => "300x300", :thumb => "100x100"}

  def self.slides
    Asset.where("url is not null")
  end
end
