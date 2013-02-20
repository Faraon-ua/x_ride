class PartsController < ApplicationController
  before_filter :authorize_owner_or_admin, :only => [:edit, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create]
  helper_method :is_owner_or_admin


  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.all_filtered params
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
    @part = Part.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @part }
    end
  end

  # GET /parts/new
  # GET /parts/new.json
  def new
    @part = Part.new
    5.times { @part.assets.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @part }
    end
  end

  # GET /parts/1/edit
  def edit
    @part = Part.find(params[:id])
    5.times { @part.assets.build }
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(params[:part])
    @part.user_id = current_user.id
    if @part.assets.size == 0
      flash.now[:error] = "Part has to have at least one picture attached"
      5.times { @part.assets.build }
      render action: "new"
      return
    end
    respond_to do |format|
      if @part.save
        format.html { redirect_to @part, notice: 'Part was successfully created.' }
        format.json { render json: @part, status: :created, location: @part }
      else
        format.html { render action: "new" }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parts/1
  # PUT /parts/1.json
  def update
    @part = Part.find(params[:id])

    respond_to do |format|
      if @part.update_attributes(params[:part])
        format.html { redirect_to @part, notice: 'Part was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part = Part.find(params[:id])
    @part.destroy

    respond_to do |format|
      format.html { redirect_to parts_url }
      format.json { head :no_content }
    end
  end
end