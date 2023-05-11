class CommentsController < ApplicationController
  def index #renvoie tous les commentaires liés à un gossip
    @all_comments = Comment.find_by(params[:id_gossip].to_i)
  end

  def show
    @one_comment = Comment.find(params[:id].to_i)
  end 

  def new
    @comment = Comment.new
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.new(comment_params) #new changé par create
    @comment.gossip_id = @gossip.id
    @comment.user_id = current_user.id
    
    @comment.save  #il faut faire les commandes d'erreurs
    redirect_to gossip_path(@gossip, success_comment_create:true)
    #else
    #  render 'new' # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    #end

  end 

  def edit 
    @comment = Comment.find(params[:id])
  end 

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(content:params[:content]) 
      redirect_to gossip_path(@comment.gossip_id, success_comment_update:true) 
    else
      render 'edit' 
    end
  end 

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.delete
      redirect_to gossip_path(@comment.gossip_id, success_comment_delete:true)
    end
  end 

end
