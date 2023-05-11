class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :check_user_author, only: [:edit, :update, :destroy]
  

  def index
    @all_gossips = Gossip.all
  end

  def show
    @one_gossip = Gossip.find(params[:id].to_i)
  end 

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title:gossip_params["title"],content:gossip_params["content"])
    @gossip.user_id = current_user.id

    if @gossip.save # essaie de sauvegarder en base @gossip
      puts gossip_params["tag_list"]
      gossip_params["tag_list"].drop(1).each do |tag_number|
        JoinTagGossip.create(gossip_id: @gossip.id, tag_id: tag_number)
      end 

      redirect_to gossips_path(success_gossip_create:true) # si ça marche, il redirige vers la page d'index du site
    else
      render 'new' # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end 

  def edit 
    @gossip = Gossip.find(params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(title:params[:title],content:params[:content]) 
      redirect_to gossip_path(params[:id], success_gossip_update:true) 
    else
      render 'edit' 
    end
  end 

  def destroy
    @gossip = Gossip.find(params[:id])

    if @gossip.delete
      redirect_to gossips_path(success_gossip_delete:true) 
    end
  end 

  private
    def gossip_params
      params.require(:gossip).permit(:title, :content, :user_id, :tag_list => [])
    end

    def authenticate_user
      unless current_user
        redirect_to new_session_path(connexion_obligatoire:true)
      end
    end

    def check_user_author
      unless current_user.id == Gossip.find(params[:id].to_i).user.id
        redirect_to gossip_path(params[:id],impossible:true)
      end
    end

end
