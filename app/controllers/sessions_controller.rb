class SessionsController < ApplicationController
  def new
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(login: params[:login])
    puts user
    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to gossips_path(success_login:true)
    else
      render 'new'
    end
  end 

  def destroy
    session.delete(:user_id)
    redirect_to gossips_path(success_disconnect:true)
  end

  #private
  #  def session_params
  #    params.permit(:login, :password)
  #  end
end
