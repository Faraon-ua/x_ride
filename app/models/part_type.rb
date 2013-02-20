class PartType < ActiveRecord::Base
  attr_accessible :title, :picture
  has_many :parts
  has_attached_file :picture, :styles => {:medium => "200x150"}
end
