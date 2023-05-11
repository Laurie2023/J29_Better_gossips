class CitiesController < ApplicationController
  def index
    @all_cities = City.all
  end

  def show
    @one_city = City.find(params[:id].to_i)
  end 

  def new
  end

  def create
  end 

  def edit 
  end 

  def update
  end 

  def destroy
  end 
end
