class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def choose_prisoner
    @prisoners = Prisoner.all
  end
  
  
  
  def choose_game
    prisoner_id = params[:prisoner_id]
    @prisoner = Prisoner.find(prisoner_id)
    @games = @prisoner.games  
  end
  
  
  
  def play_game
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]
    @prisoner = Prisoner.find(prisoner_id)
    @game = Game.find(game_id)

    ##assuming two prisoners already in this game ##is this safe??
    @other_prisoner = nil
    @game.prisoners.each do |thispris| 
      if thispris.id != prisoner_id
        @other_prisoner = thispris
      end
    end
    
    
    ##confused, this should be backwards??!! something is fucked up
    @you_went = ! @prisoner.game_prisoners.where(:game_id == game_id).first.confess.nil?
    @they_went = ! @other_prisoner.game_prisoners.where(:game_id == game_id).first.confess.nil?

    puts "TESTING - " + @prisoner.id.to_s + ' ' + @other_prisoner.id.to_s + " - DONE TESTING"
    puts "TESTING - " + @you_went.to_s + ' ' + @they_went.to_s + " - DONE TESTING"


  end



  def plead_guilty
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    gp = GamePrisoner.where(:prisoner_id => prisoner_id, :game_id => game_id).first
    #puts "TESTING - " + gp.to_s + " - DONE TESTING"
    gp.confess = TRUE
    gp.save!

    redirect_to(:action => 'play_game', :message => 'plead_guilty')
  end
 
 
 
  def plead_innocent
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    gp = GamePrisoner.where(:prisoner_id => prisoner_id, :game_id => game_id).first
    gp.confess = FALSE
    gp.save!
   
   redirect_to(:action => 'play_game', :message => 'plead_innocent')
  end 
  
  
  
end
