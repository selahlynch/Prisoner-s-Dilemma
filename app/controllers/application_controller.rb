class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      return true
    end
  end
  
  def confirm_admin
  #  unless Prisoner.find(session[:user_id]).is_admin
  ##    flash[:notice] = "Admin access only."
   ##   redirect_to(:controller => 'access', :action => 'welcome')
    #  return false
   # else
   #   return true
   # end
  end

  
end
