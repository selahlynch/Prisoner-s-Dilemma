class AccessController < ApplicationController

  before_filter :confirm_logged_in, :only => [:index, :welcome]

  layout 'admin'


  def index
    welcome
    render('welcome')
  end

  def welcome
    prisoner = Prisoner.find(session[:prisoner_id])
    if ! prisoner.is_admin
      redirect_to(:controller=>'play', :action=>'choose_game')
    end
    # menu with links
  end

  def login
    # login form
  end

  def attempt_login
    authorized_user=Prisoner.authenticate(params[:name], params[:pwd])
    if authorized_user
      session[:prisoner_id] = authorized_user.id
      session[:username] = authorized_user.name
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'welcome')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
      session[:prisoner_id] = nil
      session[:username] = nil
      flash[:notice] = "You have been logged out."
      redirect_to(:action => "login")
  end

end







