class Part < ActiveRecord::Base
  attr_accessible :available, :brand_name, :description, :part_type_id, :price, :title, :assets_attributes, :user_id, :region, :condition

  validates :title, :presence => true,
            :length => {:maximum => 250}
  validates :price, :numericality => true, :presence => true
  validates_presence_of :region, :condition, :available, :brand_name

  has_many :assets
  belongs_to :part_type
  accepts_nested_attributes_for :assets, :allow_destroy => true

  def availability
    case available
      when "available"
        "<font color='green'>available</font>"
      when "on_request"
        "<font color='F5B800'>on request</font>"
      when "sold_out"
        "<font color='red'>sold out</font>"
    end
  end

  def self.conditions
    Part.pluck(:condition).uniq
  end

  def self.availability
    Part.pluck(:available).uniq
  end

  def self.brands
    Part.pluck(:brand_name).uniq
  end

  def self.all_filtered(params)
    params.each { |key, value| params[key] = params[key].include?(',') ? params[key].split(',') : params[key] }
    warn params.inspect
    parts = Part.scoped
    if params.present?
      parts = parts.where(part_type_id: params[:part_types]) if params[:part_types]
      parts = parts.where(region: params[:regions]) if params[:regions]
      parts = parts.where(condition: params[:conditions]) if params[:conditions]
      parts = parts.where(available: params[:availability]) if params[:availability]
      parts = parts.where(brand_name: params[:brands]) if params[:brands]
      parts = parts.where("price BETWEEN ? AND ?", params[:min_price], params[:max_price]) if (params[:min_price].present? && params[:max_price].present?)
      if params[:search]
        search = "%#{params[:search]}%"
        parts = parts.where("(title LIKE ?) OR (description LIKE ?) OR (brand_name LIKE ?)", search, search, search)
      end

      parts = parts.order(params[:sort] + " " + params[:direction]) if params[:sort]
    end
    return parts
  end
end
