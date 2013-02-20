class Event < ActiveRecord::Base
  GOOGLE_MAPS_IFRAME_REGEXP = /(<iframe)+.*(src="https:\/\/maps.google.com\/maps)+.*(<\/iframe>)/
  attr_accessible :contacts, :coverage, :description, :distance, :end_at, :end_at_place, :name, :rate, :start_at_place, :start_at, :stuff, :event_type, :route, :event_pic, :map_url

  has_many :rsvps
  has_many :users, :through => :rsvps

  after_create :crop_map_iframe
  after_update :crop_map_iframe
  has_attached_file :event_pic, :styles => {:medium => "200x150"}

  validates_presence_of :name, :event_type, :route, :start_at, :start_at_place, :distance, :coverage, :rate, :contacts
  validates_numericality_of :distance
  validates_length_of :name, :maximum => 250

  def create_self_rsvp
    self.rsvps.create(:user_id => current_user.id)
  end

  def crop_map_iframe
    unless self.map_url.blank?
      iframe = GOOGLE_MAPS_IFRAME_REGEXP.match(self.map_url)
      iframe = iframe.nil? ? nil : iframe[0]
      if iframe != self.map_url
        warn iframe
        warn self.map_url
        self.map_url = iframe
        warn "updated map_url: #{self.map_url}"
        Event.update(self.id, :map_url => iframe)
      end
    end
  end
end
