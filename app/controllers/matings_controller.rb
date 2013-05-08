class MatingsController < ApplicationController

  def new
    @mating = Mating.new()
    respond_to do |format|
      format.json { render :json => @mating }
      format.js
      format.html
    end
  end

  def create
    @mating = Mating.new(params[:mating])
    respond_to do |format|
      if @mating.save
        format.json { render :json => @mating, :status => :created, :location => @mating }
        format.js
        format.html { redirect_to animals_url }
      end
    end
  end

  def destroy
    @mating = Mating.find(params[:id])
    @mating.destroy

    respond_to do |format|
      format.html { redirect_to animals_url}
      format.json { head :no_content }
    end
  end
end
