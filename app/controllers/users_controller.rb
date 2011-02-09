class UsersController < ApplicationController
  layout :choose_layout
  before_filter :ensure_not_logged_in, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit] 
  def show
    @user = current_user
  end
  
  def new
    @user = User.new
  end
  

  def edit
    if !current_user
      redirect_to root_url
      return false
    end
    @user = current_user
  end
  
  
  def create    
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Welcome!'
      redirect_to root_url
    else
      render :action => "new"
    end
  end
  
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated!'
      redirect_to root_url
    else
      render :action => "edit"
    end
  end
  
 def choose_layout
   case action_name
    when 'home' then 'home'
    else 'content'
  end
 end

  private
  
  def ensure_not_logged_in
    if current_user
      redirect_to root_url
      return false
    end
  end
  
end
