class RelationshipsController < ApplicationController

  # User has to be logged in before creating or destroying any relationships.
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # AJAX
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    # AJAX
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end    
  end
  
end
