class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    
  def confirm_logged_in
    unless cookies[:auth_token]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      session[:prisoner_id] = Prisoner.find_by_encrypted_password(cookies[:auth_token]).id
      session[:username] = Prisoner.find_by_encrypted_password(cookies[:auth_token]).name
      return true
    end
  end
  
  def confirm_admin
    unless Prisoner.find(session[:prisoner_id]).is_admin
      flash[:notice] = "Admin access only."
      redirect_to(:controller => 'access', :action => 'welcome')
      return false
    else
      return true
    end
  end

  def confirm_game_access
    game_id = 0  ##there should be a better way of doing this :/
  
    if !session[:game_id].nil?  
      game_id = session[:game_id]
    end
  
    if !params[:game_id].nil?
      game_id = params[:game_id]
    end
  
    print "\n\n******CONFIRM GAME ACCESS - " + game_id + " " + session[:prisoner_id].to_s + "\n\n"
  
    print "\n\n******GRRRRRR - " + Prisoner.find(session[:prisoner_id].to_i).is_in_game?(game_id.to_i).to_s + "\n\n"
  
    unless Prisoner.find(session[:prisoner_id].to_i).is_in_game?(game_id.to_i)
      flash[:notice] = "Not permitted access to this game."
      redirect_to(:controller => 'access', :action => 'welcome')
      return false
    else
      return true
    end
  end

  private

  def current_user
    @current_user ||= Prisoner.find_by_encrypted_password(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
  
end
