class LikesController < ApplicationController
  def index
  end

  def new 
  end 

  def create
    @like = Like.create(imageable_type:params[:imageable_type],
    imageable_id:params[:imageable_id], user_id:current_user.id)
    if imageable_type="Gossip"
      redirect_to gossip_path(@like.imageable.id)
    else 
      redirect_to gossip_path(Gossip.find_by(@like.imageable.gossip.id))
    end 
  end 

  def destroy 
    @like = Like.find(params[:id])
    @like.delete

    if imageable_type="Gossip"
      puts "o"*60
      redirect_to gossip_path(@like.imageable.id)
    else 
      puts "Z"*60
      redirect_to gossip_path(Gossip.find_by(@like.imageable.gossip.id))
    end 
  end 
end
