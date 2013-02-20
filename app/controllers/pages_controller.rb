class PagesController < ApplicationController
  def home
    @title = "Home"
    @slides = Asset.slides
  end

  def login_with_vk
    if params[:uid].present?
      new_user = true
      user = User.find_by_uid(params[:uid])
      unless user.present?
        user = User.new(:username => "#{params[:first_name]} #{params[:last_name]}", :password => params[:uid], :password_confirmation => params[:uid], :confirmation_sent_at => Time.now, :confirmed_at => Time.now, :uid => params[:uid], :first_name => params[:first_name], :last_name => params[:last_name], :email => "#{params[:first_name]}#{params[:last_name]}@vk.com")
        user.save
        new_user = true
      end
      sign_in user
      respond_to do |format|
        warn "format #{format.inspect}"
        format.json { render :json => {'redirect_path' => new_user ? user_profile_path(user) : "/" } }
      end
    end
  end
end
