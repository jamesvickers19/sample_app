class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      if user.approved?
        log_in user
        flash[:success] = "Account activated and approved by administrator!"
        redirect_to user
      else
        flash[:warning] = "Account activated, but not yet available; awaiting administrator approval."
        redirect_to root_url
      end
    else
      flash[:danger] = "Invalid activation linK"
      redirect_to root_url
    end
  end
  
end
