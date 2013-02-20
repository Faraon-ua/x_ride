class ProfileController < ApplicationController
  def index
    warn params
    @user = User.find(params[:id])
  end
end
