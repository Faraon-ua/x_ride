class Rsvp < ActiveRecord::Base
  attr_accessible :add_invites, :event_id, :user_id
  belongs_to :user
  belongs_to :event
end
