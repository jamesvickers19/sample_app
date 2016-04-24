class PostEncouragementsController < ApplicationController

  before_action :logged_in_user
  
  
  def create
    post = Micropost.find(params[:encouraged_id])
    current_user.encourage(post)
    # TODO: change this redirection...
    redirect_to post.user
  end

  def destroy
    post = PostEncouragement.find(params[:id]).encouraged
    current_user.removeEncouragement(post)
    # TODO: change this redirection...    
    redirect_to post.user
  end
  
end
