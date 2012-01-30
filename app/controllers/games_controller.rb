class GamesController < ApplicationController
  def new
    #@game = Game.new(:name => "Some Name")  ##this is not actually necessary
    @game = Game.new
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
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @gamee = Game.find(params[:id])  
    @all_prisoners = Prisoner.all
    @listbox_data = Prisoner.all.collect{|p| [p.name, p.id]}
    @selected_prisoner_ids = @gamee.prisoners.collect{|p| p.id}
  end

  def update  
    @game = Game.find(params[:id])

    #selected_pids = params[:prisoners]
    #old_pids = @game.prisoners.collect{|p| p.id}

    if @game.update_attributes(params[:gamee]) 
      flash[:notice] = "Game updated." 
      redirect_to(:action => 'list')
      #redirect_to(:actions => 'show', :id => @game.id, :junk = 'junk')
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
