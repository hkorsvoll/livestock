class AnimalsController < ApplicationController
  include AnimalsHelper
  before_filter :signed_in_user, :current_user_has_owner
  # GET /animals
  # GET /animals.json
  def index
    @animals = get_animals_for_pagination(params[:year])
    @years = get_years_in_stock_for_current_user
    respond_to do |format|
      format.html { render locals: {selected_year: params[:year]}}
      format.json { render :json => @animals }
    end
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    @animal = Animal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render :json => @animal }
    end
  end

  # GET /animals/close
  def close
    respond_to do |format|
      format.js
    end
  end

  # GET /animals/new
  # GET /animals/new.json
  def new
    @animal = Animal.new
    @animal.owner = current_user.owners.first
    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.json { render :json => @animal }
    end
  end

  # GET /animals/1/edit
  def edit
    @animal = Animal.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(params[:animal])
    @animal.owner = current_user.owners.first
    @animals = get_animals_for_pagination(@animal.birth_date.year.to_s)
    @years = get_years_in_stock_for_current_user

    respond_to do |format|
      if @animal.save
        flash[:notice] = 'Animal was successfully created.'
        format.html { redirect_to @animal, remote: true, :class=>'show_animal' }
        format.json { render :json => @animal, :status => :created, :location => @animal }
        format.js
      else
        format.html { render :action => "new" }
        format.json { render :json => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animals/1
  # PUT /animals/1.json
  def update
    @animal = Animal.find(params[:id])
    @animal.assign_attributes(params[:animal])
    @animals = get_animals_for_pagination(@animal.birth_date.year.to_s)
    @years = get_years_in_stock_for_current_user

    respond_to do |format|
      if @animal.save
        flash[:notice] = 'Animal was successfully updated.'
        format.html { redirect_to @animal, :remote=>true, :class=>'show_animal' }
        format.json { render :json => @animal, :status => :updated, :location => @animal }
        format.js
      else
        format.html { render :action => "edit" }
        format.json { render :json => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal = Animal.find(params[:id])
    @animals = get_animals_for_pagination(@animal.birth_date.year.to_s)
    animal_id = @animal.id_tag
    @animal.destroy
    @years = get_years_in_stock_for_current_user


    respond_to do |format|
      flash[:notice] = 'Animal '+ animal_id +' was deleted.'
      format.html { redirect_to animals_url, remote: true}
      format.json { head :no_content }
      format.js
    end
  end
end
