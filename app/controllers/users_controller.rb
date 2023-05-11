class UsersController < ApplicationController
  def index
    @all_users = User.all
  end

  def show
    @one_user = User.find(params[:id])
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(first_name:user_params["first_name"], last_name:user_params["last_name"], description:user_params["description"], email:user_params["email"], age:user_params["age"], login:user_params["login"], password:user_params["password"])
    
    cities_aray = City.all.map{|city|city.name.downcase}.to_a
    city_id = ""

    if cities_aray.include?(user_params["city"].downcase) == true 
      city_id = City.find_by(name:user_params["city"]).id
    else 
      new_city = City.create(name:user_params["city"])
      city_id = new_city.id.to_i
    end 

    @user.city_id = city_id

    if @user.save 
      session[:user_id] = @user.id
      redirect_to gossips_path(success_login:true)
      #redirect_to user_path(@user.id,success_user_create:true)
    else
      render 'new'
    end
  end 

  def edit 
  end 

  def update
  end 

  def destroy
  end 

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :description, :email, :age, :login, :password, :city)
    end
end
