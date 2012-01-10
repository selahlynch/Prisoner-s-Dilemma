class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def choose_prisoner
    @prisoners = Prisoner.all
  end
  
  def choose_game
    prisoner_id = params[:prisoner_id]
    @prisoner = Prisoner.find(prisoner_id)
    @games = Game.where(['player1_id = ? OR player2_id = ?',prisoner_id,prisoner_id])  
    ###gotta figure out how to filter this by player id!!
    ###and then combine with other player id
    ###player1_id == prisoner_id || player2_id == prisoner_id

  end
  
  def play_game
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]
    @prisoner = Prisoner.find(prisoner_id)
    @game = Game.find(game_id)

    wp = which_player(game_id, prisoner_id)
    
    @you_went = false
    @they_went = false
    
    if wp == 1
      if @game.player1_confess != nil
        @you_went = true
      end
      if @game.player2_confess != nil
        @they_went = true
      end   
    elsif wp == 2
      if @game.player1_confess != nil
        @they_went = true
      end
      if @game.player2_confess != nil
        @you_went = true
      end   
    elsif wp == 0
      redirect_to(:action => 'choose_game')         
    end
    
    ##gamestate = ????
    ## is other person logged in
    ## have they gone yet
    ## have I gone yet??
    ## are there any results?
    
    ## gotta refresh every 10s or so

    ## gamestate + wp should be enough to determine 
  end
  
  def plead_guilty
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    wp = which_player(game_id, prisoner_id)

    game = Game.find(game_id)
    
    if wp == 1
      game.player1_confess = TRUE
      game.save
    elsif wp == 2
      game.player2_confess = TRUE
      game.save
    end

    redirect_to(:action => 'play_game', :message => 'plead_guilty', :wp => wp)
 
  end
 
  def plead_innocent
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    wp = which_player(game_id, prisoner_id)

    game = Game.find(game_id)

    if wp == 1
      game.player1_confess = TRUE
      game.save
    elsif wp == 2
      game.player2_confess = TRUE
      game.save
    end
    
   redirect_to(:action => 'play_game', :message => 'plead_innocent', :wp => wp)

  end 
  
  
  def which_player(game_id, prisoner_id)
  
    puts "using which player\n"
  
    game = Game.find(game_id)
    
    #return "#{prisoner_id}x#{game.player1_id}"
    
    if game.player1_id.to_i == prisoner_id.to_i
      return 1
    elsif game.player2_id.to_i == prisoner_id.to_i
      return 2
    else
      return 0
    end
              
  end
  
  
end
