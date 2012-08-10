class AdminController < ApplicationController
  def new    
  end

  def create
    admin = Member.authenticate(params[:username], params[:password])    
    
    if admin
      sign_in admin
      session[:member_id] = admin.id
      redirect_to home_path, success: "Logged in successfully"
    else
      flash[:notice]= "Username or password incorrect"
      redirect_to root_path
    end
  end

  def destroy
    session[:member_id] = nil
    sign_out
    redirect_to root_path, notice: "Logged out successfully"
  end
end
