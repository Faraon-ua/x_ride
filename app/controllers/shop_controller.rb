class ShopController < ApplicationController
  def show
    @user = User.find_by_username(params[:name])

    if @user
      @part_types = @user.part_types.uniq
    else
      @part_types = PartType.all
    end
  end
end
