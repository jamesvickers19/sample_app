class PostEncouragementsController < ApplicationController

  before_action :logged_in_user
  
  
  def create
    post = Micropost.find(params[:encouraged_id])
    current_user.encourage(post)
    redirect_to request.referrer  # either home page or a user's page.
  end

  def destroy
    post = PostEncouragement.find(params[:id]).encouraged
    current_user.removeEncouragement(post)
    redirect_to request.referrer # either home page or a user's page.
  end
  
end
