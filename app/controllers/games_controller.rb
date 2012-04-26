class GamesController < ApplicationController


  ##commented for api calling
  #before_filter :confirm_logged_in
  #before_filter :confirm_admin

  def new
    #@game = Game.new(:name => "Some Name")  ##this is not actually necessary
    @game = Game.new
    @prisoner_select_data = Prisoner.all.collect{|p| [p.name, p.id]}
  end

  def create
    @game = Game.new(params[:game])
    if @game.save 
      flash[:notice] = "Game created."
      redirect_to(:action => 'list')
    else
      render 'new'  ##just rendering template, not running controller function
    end
  end
  
  def index
    list
    render('list')
  end
  
  def list
    @games = Game.all
    #@games = Game.order("games.name ASC")
 
    if params[:format] == 'json'
      render :json => @games
    end
 
    #respond_to do |format|
    #  format.html { render 'list'}
    #  format.json { render json: @games }
    #end
 
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])  
    @prisoner_select_data = Prisoner.all.collect{|p| [p.name, p.id]}
  end

  def update  
    @game = Game.find(params[:id])
    
    if @game.update_attributes(params[:game]) 
      flash[:notice] = "Game updated." 


      ##switched temoporatrily for JS
      #redirect_to(:action => 'list')
      render :text => "Game updated."

    else
      render 'edit'  ##just rendering template, not running controller function
    end
  end

  def delete
    @game = Game.find(params[:id])
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:notice] = "Game destroyed."
    redirect_to(:action => 'list')
  end

end
