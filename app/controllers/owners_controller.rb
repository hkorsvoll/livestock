class OwnersController < ApplicationController
  include OwnersHelper
  before_filter :signed_in_user, :current_user_has_owner

  # GET /owners/1
  # GET /owners/1.json
  def show
    @owner = Owner.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @owner}
    end
  end

  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @owners }
    end
  end

  def create
    @owner = Owner.new(params[:owner])
    if @owner.save
      flash[:success] = "Owner created"
      redirect_to @owner
    else
      render 'new'
    end
  end

  def new
    @owner = Owner.new
  end

  def edit

  end

  def update

  end

  def destroy
    Owner.find(params[:id]).destroy
    flash[:success] = "Owner is deleted"
    redirect_to owners_url
  end
end
