class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  before_filter :set_locale
  protect_from_forgery
  helper :all

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def is_admin?
    if user_signed_in?
      current_user.email == "faraon.ua@gmail.com"
    end
  end
  helper_method :is_admin?

  def authorize_owner_or_admin
    redirect_to user_session_path unless is_owner_or_admin
  end

  def is_owner_or_admin(id = nil)
    return false unless user_signed_in?
    case controller_name
      when "parts" then
        part_id = id || params[:id]
        part = Part.find(part_id)
        return is_admin? || current_user.parts.include?(part)
      when "events" then
        event_id = id || params[:id]
        event = Event.find(event_id)
        return is_admin? || current_user.parts.include?(event)
    end
  end
end
