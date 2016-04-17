class AccountApprovalsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.approved? && user.authenticated?(:approval, params[:id])
      user.approve
      flash[:success] = "Account approved!"
    else
      flash[:danger] = "Invalid approval link"
    end
    # Don't redirect to user, as done after user account activation.  Just go to root.      
    redirect_to root_url
  end
end
